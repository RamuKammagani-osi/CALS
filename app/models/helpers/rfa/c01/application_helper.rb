# frozen_string_literal: true

class Helpers::Rfa::C01::ApplicationHelper < Helpers::ModelHelperBase
  def model_class
    Rfa::C01::Application
  end

  def all(application_id)
    model_class.all(application_id, auth_header)
  end

  def find_by_id(application_id, rfa_c01_form_id)
    model_class.find_by_id(application_id, rfa_c01_form_id, auth_header)
  end

  def update(application_id, rfa_c01_form_id, body)
    model_class.update(application_id, rfa_c01_form_id, body, auth_header)
  end
end
