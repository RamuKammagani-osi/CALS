# frozen_string_literal: true

class Helpers::Complaint < Helpers::ModelHelperBase
  def model_class
    Complaint
  end

  def find_by_facility(id)
    Complaint.find_by_facility(id, auth_header)
  end
end
