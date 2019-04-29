# frozen_string_literal: true

FactoryBot.define do
  factory :applicant_child, class: 'Rfa::ApplicantChild' do
    #  sequence(:relationship_type) #TODO: what to put here
    sequence(:date_of_birth) { Faker::Date.backward(2000) }
    #  sequence(:gender) #TODO: what to put here
    sequence(:child_financially_supported) { Faker::Boolean.boolean }
    sequence(:in_house) { Faker::Boolean.boolean }
    sequence(:child_adopted) { Faker::Boolean.boolean }
    sequence(:minor) { Faker::Boolean.boolean }
    sequence(:legal_first) { Faker::Name.first_name }
    sequence(:legal_middle) { Faker::Name.first_name }
    sequence(:legal_last) { Faker::Name.last_name }
  end
end
