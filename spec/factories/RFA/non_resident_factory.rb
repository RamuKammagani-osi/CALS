# frozen_string_literal: true

FactoryBot.define do
  factory :non_resident, class: 'Rfa::NonResident' do
    sequence(:legal_first) { Faker::Name.first_name }
    sequence(:legal_middle) { Faker::Name.first_name }
    sequence(:legal_last) { Faker::Name.last_name }
  end
end
