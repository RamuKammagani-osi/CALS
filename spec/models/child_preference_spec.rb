# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe ChildPreference do
  it 'builds a default child preference' do
    child_preference = FactoryBot.build(:child_preference, age_group_preference: [3])
    expect(child_preference.age_group_preference).to eq([3])
  end
end
