# frozen_string_literal: true

FactoryBot.define do
  factory :facility, class: 'Facility' do
    sequence(:name) { Faker::Lorem.sentence(1, true, 2) }
    sequence(:id) { Faker::Number.number(2) }
  end

  factory :facilities, class: 'Facility' do
    facilities { create_list(:facility, 50) }
  end
end
