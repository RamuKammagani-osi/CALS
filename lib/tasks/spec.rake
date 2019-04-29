# frozen_string_literal: true

def host_env_string
  'REDIS_HOST=$(docker-machine ip cals) REDIS_PORT=6379'
end

namespace :build_rails do
  task :bundle_yarn do
    command = 'bundle install && yarn'
    system "docker-compose exec -T cals bash -c '#{command}'"
  end
end

namespace :spec do
  def file_list
    # first ARGV is task name
    args = ARGV.drop(1)
    args.any? ? args.join(' ') : 'spec'
  end

  def webpack_command
    run_webpack = file_list == 'spec' || file_list == 'spec/' || file_list.include?('features')
    'bin/webpack &&' if run_webpack
  end

  desc 'Run specs in cals container'
  task :cals do
    command = "RAILS_ENV=test bundle exec rspec #{file_list}"
    sh "#{webpack_command} docker-compose exec -T cals bash -c '#{command}'"
  end

  # namespace :cals do
  #   desc 'Run specs locally outside container'
  #   task :local do
  #     system "#{webpack_command} #{host_env_string} bundle exec rspec #{file_list}"
  #   end
  #   desc 'Run specs in parallel in cals container (from host)'
  #   task :parallel do
  #     # docker-compose supports ENV vars for run, but not exec (yet?)
  #     # We need to set RAILS_ENV because the spawned spec processes pick up
  #     # RAILS_ENV=development from our dev environment.
  #     docker_cmd = <<~END.tr("\n", ' ')
  #     docker-compose run
  #     -e RAILS_ENV=test
  #     --rm cals
  #     bundle exec parallel_rspec
  #     END
  #     system "#{webpack_command} #{docker_cmd} #{file_list}"
  #   end

  #   desc 'Run ALL THE SPECS, LINT, & KARMA!!!'
  #   task :full do
  #     Rake::Task['spec:cals:parallel'].invoke
  #     system 'bin/lint'
  #     system 'bin/karma'
  #   end
  # end
end
