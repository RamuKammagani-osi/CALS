# frozen_string_literal: true

FactoryBot.define do
  factory :alternative_name, class: 'AlternativeName' do
    sequence(:first_name) { Faker::Name.first_name }
    sequence(:middle_name) { Faker::Name.first_name }
    sequence(:last_name) { Faker::Name.last_name }
  end
end
