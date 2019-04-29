# frozen_string_literal: true

FactoryBot.define do
  factory :child_preference, class: 'ChildPreference' do
    sequence(:age_group_preference) { Faker::Number.number(1) }
    sequence(:sibling_group_size) { Faker::Number.number(1) }
    # has_many :age_group_preferences
    #  has_many :sibling_groups
  end
end
