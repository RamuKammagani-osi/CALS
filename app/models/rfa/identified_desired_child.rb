# frozen_string_literal: true

class Rfa::IdentifiedDesiredChild < CalsBase
  # FORM 01A
  attr_accessor :currently_in_home
  # TODO: add in correct fields from form C
  attr_accessor :date_of_birth, :gender, :jurisdiction_county, :date_of_placement,
                :relationship, :education_level,
                # TODO: should we make this into a school model with a has_one address?
                :school_name, :school_street, :school_zip, :school_city, :school_state,
                :legal_last, :legal_middle, :legal_first
  # belongs_to :rfa_application
end
