# frozen_string_literal: true

FactoryBot.define do
  factory :identified_desired_child, class: 'Rfa::IdentifiedDesiredChild' do
    sequence(:currently_in_home) { Faker::Boolean.boolean }
    sequence(:date_of_birth) { Faker::Date.birthday }
    #  sequence(:gender) #TODO: what's this dropdown
    #  sequence(:jurisdiction_county) #TODO: what's this dropdown
    sequence(:date_of_placement) { Faker::Date.backward(1000) }
    #  sequence(:education_level) #TODO: what's this dropdown
    sequence(:school_name) { Faker::Educator.secondary_school }
    sequence(:school_street) { Faker::Address.street_address }
    sequence(:school_zip) { Faker::Address.zip }
    sequence(:school_city) { Faker::Address.city }
    sequence(:school_state) { Faker::Address.state_abbr }
    sequence(:legal_first) { Faker::Name.first_name }
    sequence(:legal_middle) { Faker::Name.first_name }
    sequence(:legal_last) { Faker::Name.last_name }

    #  has_one      :relationship
  end
end
