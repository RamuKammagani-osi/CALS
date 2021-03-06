# frozen_string_literal: true

require 'faraday'
require_relative 'api_error'

module CalsFaradayMiddleware
  # custom faraday handle error exception class
  class ApiErrorException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        handle_response(env, response)
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    def handle_response(env, response)
      status = response[:status]

      case status
      when 422, 500, 403, 400
        raise_error(env, response)
      end
    end

    def raise_error(_env, response)
      body = response.body
      raise ApiError.new(body, response[:status], response[:url])
    end
  end
end
