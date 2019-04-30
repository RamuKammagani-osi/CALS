# frozen_string_literal: true

SystemInformation.configure do |config|
  config.application = 'Cals App'
  config.version = ENV.fetch('APP_VERSION', 'unknown').to_s
  config.checks =
    [
      { name: :redis,
        url: "redis://#{ENV.fetch('REDIS_HOST', 'localhost')}:"\
          "#{ENV.fetch('REDIS_PORT', 6379)}" },
      { name: :perry,
        url: "#{ENV.fetch('AUTHENTICATION_API_BASE_URL', 'http://localhost/perry')}/"\
          'system-information' },
      { name: :cals_api,
        url: "#{ENV.fetch('CALS_API_URL', 'http://localhost/cals')}/"\
          'system-information' },
      { name: :dora_api,
        url: "#{ENV.fetch('BASE_SEARCH_API_URL', 'http://localhost/dora')}/"\
        'system-information' },
      { name: :geo_api,
        url: "#{ENV.fetch('GEO_SERVICE_URL', 'http://localhost/geo')}/"\
      'system-information' }
    ]
end
