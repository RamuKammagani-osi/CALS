# frozen_string_literal: true

module Concerns::Rfa::C01::ApplicationC01ApiProtocolProvider
  extend ActiveSupport::Concern
  include Concerns::RfaBaseApiProtocolProvider

  class_methods do
    def all(application_id, auth_header)
      response = FaradayCals.get('/rfa-1a-forms/' + application_id + '/rfa-1c-forms/', auth_header)
      response.status == 200 ? JSON.parse(response.body) : nil
    end

    def find_by_id(application_id, rfa_c01_form_id, auth_header)
      response = FaradayCals.get('/rfa-1a-forms/' + application_id + '/rfa-1c-forms/' + rfa_c01_form_id, auth_header)
      JSON.parse(response.body)
    end

    def update(application_id, rfa_c01_form_id, body, auth_header)
      response = FaradayCals.put('/rfa-1a-forms/' + application_id + '/rfa-1c-forms/' + rfa_c01_form_id, auth_header, body)
      response.status == 200 ? JSON.parse(response.body) : nil
    end
  end
end
