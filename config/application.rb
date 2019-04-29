# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cals
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.logger = ActiveSupport::Logger.new(STDOUT)
    config.log_level = :debug

    config.react.addons = true

    # Settings for the pool of renderers:
    config.react.server_renderer_timeout ||= 20 # seconds
    config.react.server_renderer = React::ServerRendering::BundleRenderer
    config.react.server_renderer_options = {
      files: ['server_rendering.js'],       # files to load for prerendering
      replay_console: true,                 # if true, console.* will be replayed client-side
    }
    # Changing files matching these dirs/exts will cause the server renderer to reload:
    config.react.server_renderer_extensions = %w[jsx js]
    config.react.server_renderer_directories = ['/app/assets/javascripts', '/app/javascripts/']

    # use environment variable to set sub-directory/sub-uri for deployment
    config.relative_url_root = ENV['RAILS_RELATIVE_URL_ROOT'] || '/'

    # change output to resolve conflicts with assets of other projects
    config.assets.prefix = "#{ENV['RAILS_RELATIVE_URL_ROOT']}/assets"
    # config.action_controller.relative_url_root = ENV['RAILS_RELATIVE_URL_ROOT'] || '/'
    #  config.cache_store = :redis_store
    config.middleware.use SystemInformation::SystemInformationMiddleware
  end
end
