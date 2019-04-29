# frozen_string_literal: true

FactoryBot.define do
  factory :signatory, class: 'Signatory' do
    sequence(:city) { Faker::Address.city }
    sequence(:county) { Faker::Address.city }
    sequence(:date) { Faker::Date.backward(2400) }
    #  :applicant_id
  end
end
