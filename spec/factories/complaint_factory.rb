# frozen_string_literal: true

FactoryBot.define do
  factory :complaint, class: 'Complaint' do
    sequence(:id) { Faker::Number.number(9) }
    sequence(:code) { Faker::Number.number(2) }
  end

  factory :complaints, class: 'Complaint' do
    complaints { create_list(:complaint, 10) }
  end
end
