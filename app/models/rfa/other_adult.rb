# frozen_string_literal: true

class Rfa::OtherAdult < CalsBase
  include Concerns::Rfa::ApplicationOtherAdultsApiProtocolProvider
  attr_accessor :id, :first_name, :middle_name, :last_name, :date_of_birth, :is_residing_in_home,
                :relationship_to_applicants, :applicant_id, :relationship_to_applicant

  # {
  #   "id": 0,
  #   "name_prefix": {
  #     "id": 0,
  #     "value": "string"
  #   },
  #   "first_name": "Anna",
  #   "middle_name": "L.",
  #   "last_name": "Pollen",
  #   "name_suffix": {
  #     "id": 0,
  #     "value": "string"
  #   },
  #   "date_of_birth": "1995-07-14",
  #   "relationship_to_applicants": [
  #     {
  #       "applicant_id": 1234567,
  #       "relationship_to_applicant": {
  #         "id": 0,
  #         "value": "string"
  #       }
  #     }
  #   ]
  # }

  def self.parent_path
    'rfa-1a-forms'
  end

  def self.api_resource_path
    'other-adults'
  end
end
