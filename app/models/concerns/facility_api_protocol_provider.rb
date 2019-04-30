# frozen_string_literal: true

module Concerns::FacilityApiProtocolProvider
  extend ActiveSupport::Concern
  include Concerns::BaseCalsApiProtocolProvider

  class_methods do
    def search(query, auth_header)
      response = FaradaySearch.post("/dora/#{class_name_downcase_pluralized}/#{class_name_downcase_pluralized.singularize}/_search",
                                    auth_header,
                                    query)
      JSON.parse(response.body)
    end
  end

  included do
    # def instance_method_example
    #   'example of an instance method'
    # end
  end
end
