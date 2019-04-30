# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Rfa::NonResident do
  it 'builds a default non resident' do
    non_resident = FactoryBot.build(:non_resident, legal_middle: 'test middle')
    expect(non_resident.legal_middle).to eq('test middle')
  end
end
