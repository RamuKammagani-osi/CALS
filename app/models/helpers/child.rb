# frozen_string_literal: true

class Helpers::Child < Helpers::ModelHelperBase
  def model_class
    Child
  end

  def find_by_facility(id)
    Child.find_by_facility(id, auth_header)
  end
end
