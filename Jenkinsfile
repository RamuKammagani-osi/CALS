#!/usr/bin/env groovy
import groovy.transform.Field
@Library('jenkins-pipeline-utils') _

@Field
def newTag = ''
@Field
def branch
@Field
def appDockerImage
@Field
def DOCKER_GROUP = 'cwds'
@Field
def DOCKER_APP_IMAGE = 'cals'
@Field
def DOCKER_TEST_IMAGE = 'cals_acceptance_test'
@Field
def GITHUB_CREDENTIALS_ID = '433ac100-b3c2-4519-b4d6-207c029a103b'
@Field
def SUCCESS_COLOR = '#11AB1B'
@Field
def FAILURE_COLOR = '#FF0000'

switch(env.BUILD_JOB_TYPE) {
  case "master": buildMaster(); break;
  case "release":releasePipeline(); break;
  default: buildPullRequest();
}

def buildPullRequest() {
  node('cals-slave') {
    def triggerProperties = githubPullRequestBuilderTriggerProperties()
    properties([
      githubConfig(),
      pipelineTriggers([triggerProperties])
    ])
    env.DISABLE_SPRING = 1
    branch = env.GIT_BRANCH
    try {
      deleteDir()
      checkOutGithub()
      verifySemVer()
      buildDockerImage()
      runTestInsideContainer()
    } catch(Exception exception) {
      currentBuild.result = 'FAILURE'
      throw exception
    } finally {
      cleanUp()
      notify(newTag)
    }
  }
}

def buildMaster() {
  node('cals-slave') {
    triggerProperties = pullRequestMergedTriggerProperties('VaNTgW28V7r6FxCn')
    properties([
      githubConfig(),
      pipelineTriggers([triggerProperties])
    ])
    env.DISABLE_SPRING = 1
    branch = env.GIT_BRANCH
    try {
      deleteDir()
      checkOutGithub()
      buildDockerImage()
      runTestInsideContainer()
      incrementTag()
      tagRepo()
      dockerStages(newTag)
      triggerReleasePipeline()
    } catch(Exception exception) {
      currentBuild.result = 'FAILURE'
      throw exception
    } finally {
      cleanUp()
      notify(newTag)
    }
  }
}

def releasePipeline() {
  parameters([
    string(name: 'APP_VERSION', defaultValue: '', description: 'App version to deploy')
  ])

  try {
    deployWithSmoke('preint')
    deployWithSmoke('integration')
  } catch(Exception exception) {
    currentBuild.result = "FAILURE"
    throw exception
  }
}

def checkOutGithub() {
  stage ('Checkout Github') {
    checkout scm
  }
}

def buildDockerImage() {
  stage('Build Docker Image') {
    appDockerImage = docker.build("${DOCKER_GROUP}/${DOCKER_APP_IMAGE}:test-${env.BUILD_ID}",
      "-f ./docker/test/Dockerfile .")
  }
}

def runTestInsideContainer() {
  appDockerImage.withRun { container ->
    stage('Lint') {
      sh "docker exec -t ${container.id} yarn lint"
    }

    stage('Test - Jasmine') {
      sh "docker exec -t ${container.id} yarn karma-ci"
    }

    stage('Test - Rspec') {
      def envVariablesRspec = 'CALS_API_URL=https://calsapi.preint.cwds.io' +
        ' -e GEO_SERVICE_URL=https://geo.preint.cwds.io' +
        ' -e BASE_SEARCH_API_URL=https://dora.preint.cwds.io' +
        ' -e AUTHENTICATION_API_BASE_URL=https://web.preint.cwds.io/perry'
        sh "docker exec -e ${envVariablesRspec} -t ${container.id} yarn spec-ci"
    }

    stage('Reports') {
      sh "docker cp ${container.id}:cals/reports ./reports"
        reports()
    }
  }
}

def verifySemVer() {
  stage('Verify SemVer Label') {
    checkForLabel('cals')
  }
}

def incrementTag() {
  stage("Increment Tag") {
    newTag = newSemVer()
  }
}

def tagRepo() {
  stage('Tag Repo') {
    tagGithubRepo(newTag, GITHUB_CREDENTIALS_ID)
  }
}

def dockerStages(newTag) {
  stage('Docker App Build Publish') {
    pushToDocker(
      "${DOCKER_GROUP}/${DOCKER_APP_IMAGE}:${newTag}",
      "-f ./docker/release/Dockerfile .",
      DOCKER_CREDENTIALS_ID
    )
  }

  stage('Docker Test Build Publish') {
    pushToDocker(
      "${DOCKER_GROUP}/${DOCKER_TEST_IMAGE}:${newTag}",
      "-f ./docker/acceptance-tests/Dockerfile .",
      DOCKER_CREDENTIALS_ID
    )
  }
}

def pushToDocker(imageLocation, args, docker_credential_id) {
  def app = docker.build(imageLocation, args)
  withEnv(["DOCKER_CREDENTIALS_ID=${docker_credential_id}"]) {
    withDockerRegistry([credentialsId: docker_credential_id]) {
      app.push()
    }
  }
}

def cleanUp() {
  stage('Clean Up') {
    sh "docker rmi `docker images ${DOCKER_GROUP}/${DOCKER_APP_IMAGE} --filter 'before=${DOCKER_GROUP}/${DOCKER_APP_IMAGE}:test-${env.BUILD_ID}' -q` -f || true"
    sh "docker rmi `docker images ${DOCKER_GROUP}/${DOCKER_TEST_IMAGE} --filter 'before=${DOCKER_GROUP}/${DOCKER_TEST_IMAGE}:${newTag}' -q` -f || true"
    sh "docker rmi `docker images --filter 'dangling=true' -q` -f || true"
  }
}

def reports() {
  publishHTML (target: [
    allowMissing: false,
    alwaysLinkToLastBuild: false,
    keepAll: true,
    reportDir: 'reports/coverage/karma',
    reportFiles: 'index.html',
    reportName: 'JS Code Coverage'
  ])

  publishHTML (target: [
    allowMissing: false,
    alwaysLinkToLastBuild: false,
    keepAll: true,
    reportDir: 'reports/coverage/rspec',
    reportFiles: 'index.html',
    reportName: 'Ruby Code Coverage'
  ])
}

def notify(String tagNumber) {
  def colorCode = currentBuild.currentResult == 'SUCCESS' ? SUCCESS_COLOR : FAILURE_COLOR
  def tagMessage = (tagNumber != '') ? "\nDocker tag: ${tagNumber}" : ''

  slackSend(
    baseUrl: 'https://hooks.slack.com/services/',
    tokenCredentialId: SLACK_CREDENTIALS_ID,
    channel: '#tech-cals-updates',
    color: colorCode,
    message: "${env.JOB_NAME} #${env.BUILD_NUMBER} - *${currentBuild.currentResult}* after ${currentBuild.durationString}" +
      "${tagMessage}" +
      "\n(Details at ${env.BUILD_URL})"
  )
}

def githubConfig() {
  githubConfigProperties('https://github.com/ca-cwds/CALS')
}

def triggerReleasePipeline() {
  stage('Trigger Release Pipeline') {
    withCredentials([usernameColonPassword(credentialsId: 'fa186416-faac-44c0-a2fa-089aed50ca17', variable: 'jenkinsauth')]) {
      sh "curl -v -u $jenkinsauth 'http://jenkins.mgmt.cwds.io:8080/job/PreInt-Integration/job/deploy-cals-app/buildWithParameters" +
      "?token=trigger-cals-deploy" +
      "&cause=Caused%20by%20Build%20${env.BUILD_ID}" +
      "&APP_VERSION=${newTag}'"
    }
  }
}

def checkOutStage() {
  stage('Check Out Stage') {
    cleanWs()
    git branch: 'master', credentialsId: GITHUB_CREDENTIALS_ID, url: 'git@github.com:ca-cwds/CALS.git'
  }
}

def deployWithSmoke(environment) {
  node(environment) {
    checkOutStage()
    deployToStage(environment, env.APP_VERSION)
    updateManifestStage(environment, env.APP_VERSION)
    // smokeTest(environment)
  }
}

def deployToStage(environment, version) {
  stage("Deploy to $environment") {
    ws {
      git branch: "master", credentialsId: GITHUB_CREDENTIALS_ID, url: 'git@github.com:ca-cwds/de-ansible.git'
      sh "ansible-playbook -e NEW_RELIC_AGENT=true -e CALS_APP_VERSION=$version -i inventories/$environment/hosts.yml deploy-cals.yml --vault-password-file ~/.ssh/vault.txt -vv"
    }
  }
}

def updateManifestStage(environment, version) {
  stage('Update Manifest Version') {
    updateManifest("cals", environment, GITHUB_CREDENTIALS_ID, version)
  }
}

 def smokeTest(environment) {
  stage("Smoke test on $environment") {
    if(environment == 'preint') {
      withEnv(["CAPYBARA_APP_HOST=https://web.${environment}.cwds.io/cals",
               "CAPYBARA_DRIVER=selenium",
               "USERNAME=${USERNAME}"]) {
        sh "docker-compose -f docker/acceptance-tests/docker-compose.yml run -e SELENIUM_BROWSER=HEADLESS_CHROME -e TEST_END_TO_END=true cals_acceptance_test bundle exec rspec spec/acceptance/facilities"
      }
    } else {
      withCredentials([
        string(credentialsId: 'c24b6659-fd2c-4d31-8433-835528fce0d7', variable: 'ACCEPTANCE_TEST_USER'),
        string(credentialsId: '48619eb9-4a74-4c84-bc25-81557ed9dd7d', variable: 'ACCEPTANCE_TEST_PASSWORD'),
        string(credentialsId: 'f75da5fa-b2c8-4ca5-896a-b8a85fa30572', variable: 'VERIFICATION_CODE')
      ]) {
        withEnv(["CAPYBARA_APP_HOST=https://web.${environment}.cwds.io/cals",
                 "CAPYBARA_DRIVER=selenium",
                 "ACCEPTANCE_TEST_USER=${ACCEPTANCE_TEST_USER}",
                 "ACCEPTANCE_TEST_PASSWORD=${ACCEPTANCE_TEST_PASSWORD}",
                 "VERIFICATION_CODE=${VERIFICATION_CODE}"]) {
          sh "docker-compose -f docker/acceptance-tests/docker-compose.yml run -e SELENIUM_BROWSER=HEADLESS_CHROME -e TEST_END_TO_END=true cals_acceptance_test bundle exec rspec spec/acceptance/facilities"
        }
      }
    }
  }
}
