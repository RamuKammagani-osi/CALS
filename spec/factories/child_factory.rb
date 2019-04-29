# frozen_string_literal: true

FactoryBot.define do
  factory :child, class: 'Child' do
    sequence(:name) { Faker::Lorem.sentence(1, true, 2) }
    sequence(:id) { Faker::Number.number(2) }
  end

  factory :children, class: 'Child' do
    children { create_list(:child, 5) }
  end
end
