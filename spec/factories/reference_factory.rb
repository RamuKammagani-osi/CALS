# frozen_string_literal: true

FactoryBot.define do
  factory :reference, class: 'Reference' do
    sequence(:email_address) { Faker::Internet.email }
    sequence(:legal_first) { Faker::Name.first_name }
    sequence(:legal_middle) { Faker::Name.first_name }
    sequence(:legal_last) { Faker::Name.last_name }

    #  has_one :address
    #  has_one :phone
  end
end
