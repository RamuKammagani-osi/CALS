# frozen_string_literal: true

class Helpers::Facility < Helpers::ModelHelperBase
  def model_class
    Facility
  end

  def search(query)
    Facility.search(query, auth_header)
  end
end
