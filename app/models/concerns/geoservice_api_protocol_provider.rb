# frozen_string_literal: true

module Concerns::GeoserviceApiProtocolProvider
  extend ActiveSupport::Concern

  class_methods do
    def suggest(params, auth_header)
      response = FaradayGeoservice.get('/' + api_resource_path + '/' + 'suggest' + '/' + params[:_json], auth_header)
      JSON.parse(response.body)
    end

    def validate(auth_header, body)
      response = FaradayGeoservice.post("/#{api_resource_path}/validate", auth_header, body)
      JSON.parse(response.body)
    end
  end
end
