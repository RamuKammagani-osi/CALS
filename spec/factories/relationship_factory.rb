# frozen_string_literal: true

FactoryBot.define do
  factory :relationship, class: 'Relationship' do
    #  sequence(:relationship_type) #TODO: whats this
    sequence(:union_date) { Faker::Date.backward(680) }
    sequence(:union_city) { Faker::Address.city }
    sequence(:term_reason) { Faker::Lorem.words(12) }
    sequence(:term_date) { Faker::Date.backward(920) }
    sequence(:term_city) { Faker::Address.city }
    sequence(:term_state) { Faker::Address.state_abbr }
    sequence(:legal_first) { Faker::Name.first_name }
    sequence(:legal_middle) { Faker::Name.first_name }
    sequence(:legal_last) { Faker::Name.last_name }
  end
end
