# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Address do
  it 'builds a default address' do
    address = FactoryBot.build(:address, zip: 95_823)
    expect(address.zip).to eq(95_823)
  end
end
