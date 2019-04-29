# frozen_string_literal: true

class Helpers::Rfa::B01::ApplicationHelper < Helpers::ModelHelperBase
  def model_class
    Rfa::B01::Application
  end

  def create_application(application_id, applicant_id, api_url_path)
    model_class.create_application(auth_header, application_id, applicant_id, api_url_path)
  end

  def all(application_id)
    model_class.all(application_id, auth_header)
  end

  def find_by_id(id, application_id)
    model_class.find_by_id(id, application_id, auth_header)
  end

  def update(id, application_id, body)
    model_class.update(id, application_id, body, auth_header)
  end

  def rfa_01a_application(application_id)
    Rfa::Application.find_by_application_id(auth_header, application_id)
  end
end
