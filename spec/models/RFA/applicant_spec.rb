# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Rfa::Applicant do
  it 'builds a default Applicant' do
    applicant = FactoryBot.build(:applicant, driver_license_number: 'D12345678')
    expect(applicant.driver_license_number).to eq('D12345678')
  end
end
