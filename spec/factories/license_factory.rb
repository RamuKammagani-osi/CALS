# frozen_string_literal: true

FactoryBot.define do
  factory :license, class: 'License' do
    sequence(:agency_name) { Faker::Company.name }
    #   sequence(:license_type) {} #TODO:what to put here
    #   sequence(:license_history_type) {} #TODO:what to put here
  end
end
