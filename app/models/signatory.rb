# frozen_string_literal: true

class Signatory < CalsBase
  attr_accessor :city, :county, :date, :applicant_id

  # belongs_to :rfa_application
end
