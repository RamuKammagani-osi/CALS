# frozen_string_literal: true

FactoryBot.define do
  factory :inspection, class: 'Inspection' do
    sequence(:id) { Faker::Number.number(9) }
  end

  factory :inspections, class: 'Inspection' do
    inspections { create_list(:inspection, 10) }
  end
end
