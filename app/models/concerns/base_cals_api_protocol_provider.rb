# frozen_string_literal: true

module Concerns::BaseCalsApiProtocolProvider
  extend ActiveSupport::Concern

  # class methods
  class_methods do
    def all(auth_header)
      response = FaradayCals.get('/' + api_resource_path, auth_header)
      JSON.parse(response.body)['items'].map { |itm| new(itm) }
    end

    def find_by_id(id, auth_header)
      response = FaradayCals.get("/#{api_resource_path}/#{id}", auth_header)
      new(JSON.parse(response.body))
    end
  end

  # instance methods
  included do
    # def update(_attrs = {})
    #   'update'
    # end
    #
    # def destroy
    #   'destroy'
    # end
  end
end
