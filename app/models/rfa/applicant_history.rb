# frozen_string_literal: true

class Rfa::ApplicantHistory < CalsBase
  include Concerns::Rfa::ApplicantHistoryApiProtocolProvider

  attr_accessor :former_spouses, :adult_children, :validation_details, :issue_details

  def self.parent_path
    'rfa-1a-forms'
  end

  def self.api_resource_path
    'applicants-history'
  end
end
