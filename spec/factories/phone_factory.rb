# frozen_string_literal: true

FactoryBot.define do
  factory :phone, class: 'Phone' do
    sequence(:number) { Faker::PhoneNumber.phone_number }
    # sequence(:phone_type) #TODO: whats this
    sequence(:preferred) { Faker::Boolean.boolean }
  end
end
