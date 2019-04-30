# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe AlternativeName do
  it 'builds a default alt name' do
    alternative_name = FactoryBot.build(:alternative_name, middle_name: 'test')
    expect(alternative_name.middle_name).to eq('test')
  end
end
