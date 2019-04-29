# frozen_string_literal: true

module Concerns::ChildApiProtocolProvider
  extend ActiveSupport::Concern
  include Concerns::BaseCalsApiProtocolProvider

  class_methods do
    def find_by_facility(id, auth_header)
      response = FaradayCals.get("/facilities/#{id}/children", auth_header)
      response.status == 200 ? JSON.parse(response.body) : nil
    end
  end
end
