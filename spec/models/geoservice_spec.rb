# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec

describe Geoservice do
  it 'Gets a default reference' do
    reference = FactoryBot.build(:reference, email_address: 'test@test.com')
    expect(reference.email_address).to eq('test@test.com')
  end
end
