# frozen_string_literal: true

class Rfa::NonResident < CalsBase
  attr_accessor :legal_first, :legal_middle, :legal_last

  # belongs_to :applicant_household_address
end
