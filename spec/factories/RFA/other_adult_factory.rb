# frozen_string_literal: true

FactoryBot.define do
  factory :other_adult, class: 'Rfa::OtherAdult' do
    #  sequence(:relationship_type) #TODO: what to put here
    sequence(:first_name) { Faker.first_name }
    # sequence(:parent_path) {'rfa-1a-forms'}
    #  sequence(:gender) #TODO: what to put here
    #   sequence(:child_financially_supported) {Faker::Boolean.boolean}
    # sequence(:in_house) {Faker::Boolean.boolean}
    #  sequence(:child_adopted) {Faker::Boolean.boolean}
    #   sequence(:minor) {Faker::Boolean.boolean}
    # sequence(:legal_first) {Faker::Name.first_name}
    # sequence(:legal_middle) {Faker::Name.first_name}
    # sequence(:legal_last) {Faker::Name.last_name}
  end
end
