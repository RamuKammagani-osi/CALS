# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Reference do
  it 'builds a default reference' do
    reference = FactoryBot.build(:reference, email_address: 'test@test.com')
    expect(reference.email_address).to eq('test@test.com')
  end
end
