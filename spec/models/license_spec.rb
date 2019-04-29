# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe License do
  it 'builds a default license' do
    license = FactoryBot.build(:license, agency_name: 'test agency name')
    expect(license.agency_name).to eq('test agency name')
  end
end
