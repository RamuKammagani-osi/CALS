# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Rfa::OtherAdult do
  it 'builds a default other adult' do
    other_adult = FactoryBot.build(:other_adult, first_name: 'keith')
    expect(other_adult.first_name).to eq('keith')
  end
end
