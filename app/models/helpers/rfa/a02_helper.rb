# frozen_string_literal: true

class Helpers::Rfa::A02Helper < Helpers::ModelHelperBase
  def model_class
    Rfa::A02
  end

  def create_a02(tracking_id)
    Rfa::A02.create_a02(auth_header, tracking_id)
  end

  def update(application_id, id, body)
    Rfa::A02.update(auth_header, application_id, id, body)
  end

  def find_by_id(application_id, id)
    Rfa::A02.find_by_id(auth_header, application_id, id)
  end

  def all(application_id)
    Rfa::A02.all(auth_header, application_id)
  end
end
