# frozen_string_literal: true

unless ENV['TEST_END_TO_END'] || ENV['DISABLE_VCR']
  require 'vcr'
  require 'webmock/rspec'

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock, :faraday
    c.allow_http_connections_when_no_cassette = true
    c.ignore_localhost = false
    c.ignore_request do |request|
      !(request.uri.starts_with?(CALS_API_URL) ||
        request.uri.starts_with?(AUTHENTICATION_API_BASE_URL) ||
        request.uri.starts_with?(GEO_SERVICE_URL) ||
        request.uri.starts_with?(BASE_SEARCH_API_URL))
    end

    # :host, :headers
    c.default_cassette_options = { match_requests_on: %i[path method] }
  end
end
