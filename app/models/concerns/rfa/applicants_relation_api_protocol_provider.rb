# frozen_string_literal: true

module Concerns::Rfa::ApplicantsRelationApiProtocolProvider
  extend ActiveSupport::Concern
  include Concerns::RfaBaseApiProtocolProvider

  class_methods do
    def create(auth_header, parent_id, body)
      response = FaradayCals.put("/#{parent_path}/#{parent_id}/#{api_resource_path}", auth_header, body)
      new(JSON.parse(response.body))
    end
  end
end
