# frozen_string_literal: true

class Rfa::ApplicantChild < CalsBase
  include Concerns::Rfa::ApplicationMinorChildrenApiProtocolProvider

  attr_accessor :id, :relationship_type, :date_of_birth, :gender,
                :child_financially_supported, :applicant_id, :in_house, :child_adopted,
                :minor, :legal_first, :legal_middle, :legal_last, :relationship_to_applicants,
                :applicant_id, :relationship_to_applicant, :issue_details

  def self.parent_path
    'rfa-1a-forms'
  end

  def self.api_resource_path
    'minor-children'
  end
end
