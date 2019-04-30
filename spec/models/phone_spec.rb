# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Phone do
  it 'builds a default phone' do
    phone = FactoryBot.build(:phone, number: 9_251_115_555)
    expect(phone.number).to eq(9_251_115_555)
  end
end
