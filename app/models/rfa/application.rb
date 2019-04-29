# frozen_string_literal: true

class Rfa::Application < CalsBase
  include Concerns::Rfa::ApplicationApiProtocolProvider
  attr_accessor :id, :is_initial_application, :is_other_type, :tracking_id, :application_county, :resource_family_name,
                :minor_children, :adoption_history, :applicants_relationship, :applicants_history,
                :residence, :references, :foster_care_history, :child_desired, :other_adults, :status,
                :relationship_between_applicants, :rfa1c_forms, :other_type_description, :applicants_declaration,
                :metadata, :placement_home_id

  attr_accessor :applicants, :minorChildren, :otherAdults, :fosterCareHistory,
                :relationshipBetweenApplicants, :applicantsHistory, :childDesired

  # has_many :applicants
  # has_many :signatories
  # has_many :references
  # has_one :child_preference
  # has_many :identified_desired_children
  # has_one :applicant_household_address
  #
  def self.api_resource_path
    'rfa-1a-forms'
  end
end
