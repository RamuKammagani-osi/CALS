# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Rfa::HouseholdAdult do
  it 'builds a default household adult' do
    household_adult = FactoryBot.build(:household_adult, legal_first: 'test first')
    expect(household_adult.legal_first).to eq('test first')
  end
end
