# frozen_string_literal: true

FactoryBot.define do
  factory :application, class: 'Rfa::Application' do
    #  sequence(:application_type) {} #TODO: what to put here
    sequence(:id) { Faker::Number.Faker::Number.number(6) }
    #    sequence(:progress_state) {} #TODO: what to put here

    # has_many :applicants
    # has_many :signatories
    # has_many :references
    # has_one :child_preference
    # has_many :identified_desired_children
    # has_one :applicant_household_address
  end
end
