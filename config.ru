# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# run Rails.application

run Rack::Builder.new {
  map ENV['RAILS_RELATIVE_URL_ROOT'] || '/' do
    run Cals::Application
  end
}
