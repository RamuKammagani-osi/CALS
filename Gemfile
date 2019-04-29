# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Environment variables configuration
gem 'dotenv-rails', '~> 2.2', groups: %i[development test aws_dev]

gem 'autoprefixer-rails', '~> 6.7'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'cwds-authentication', github: 'ca-cwds/cwds-authentication', ref: '82c1dcf'
gem 'cwds_store', github: 'ca-cwds/cwds_store'
gem 'faraday'
gem 'faraday_middleware'
gem 'jbuilder', '~> 2.5'

gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1'
gem 'react-rails', '~> 2.2'

gem 'redis'
gem 'redis-namespace'
gem 'redis-rack-cache'
gem 'redis-rails', '~> 5.0'
gem 'responders', '~> 2.3'

gem 'sass-rails', github: 'rails/sass-rails'
gem 'system_information', github: 'ca-cwds/system_information'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.2'

group :development, :test do
  gem 'awesome_print', require: 'ap'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 3.6'
  gem 'capybara-accessible', github: 'ca-cwds/capybara-accessible', branch: 'master'
  gem 'capybara-screenshot'
  gem 'chromedriver-helper', '1.2.0'
  # gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'geckodriver-helper'
  gem 'rails-controller-testing'
  gem 'rspec', '~> 3.7'
  gem 'rspec-rails', '~> 3.7'
  gem 'rubocop', '~> 0.58', require: false
  gem 'selenium-webdriver', '~> 3.11'
  gem 'transpec'
  gem 'vcr'
  gem 'webmock'
end

group :test do
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  gem 'mock_redis'
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'newrelic_rpm'
