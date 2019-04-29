# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Occupation do
  it 'builds a default occupation' do
    occupation = FactoryBot.build(:occupation, employer_name: 'test employer inc')
    expect(occupation.employer_name).to eq('test employer inc')
  end
end
