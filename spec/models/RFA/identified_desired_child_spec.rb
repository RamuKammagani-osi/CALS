# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Rfa::IdentifiedDesiredChild do
  it 'builds a default identified desired child' do
    identified_desired_child = FactoryBot.build(:identified_desired_child, currently_in_home: true)
    expect(identified_desired_child.currently_in_home).to eq(true)
  end
end
