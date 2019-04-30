# frozen_string_literal: true

FactoryBot.define do
  factory :application_residence, class: 'Rfa::ApplicationResidence' do
    # sequence(:property_type) #TODO whats this
    #  sequence(:own_rent_lease)
    sequence(:weapon_in_home) { Faker::Boolean.boolean }
    sequence(:body_of_water_exist) { Faker::Boolean.boolean }
    sequence(:directions_to_home) { Faker::Lorem.paragraph }
  end
  # has_many :non_residents
  # has_
end
