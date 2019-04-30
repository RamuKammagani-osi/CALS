# frozen_string_literal: true

module Concerns::Rfa::ApplicationReferenceApiProtocolProvider
  extend ActiveSupport::Concern
  include Concerns::RfaBaseApiProtocolProvider
  class_methods do
    def create(auth_header, parent_id, body)
      response = FaradayCals.put("/#{parent_path}/#{parent_id}/#{api_resource_path}", auth_header, body)
      JSON.parse(response.body)['items'].map { |itm| new(itm) }
    end
  end
end
