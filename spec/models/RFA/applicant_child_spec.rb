# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Rfa::ApplicantChild do
  it 'builds a default applicant child' do
    applicant_child = FactoryBot.build(:applicant_child, minor: true)
    expect(applicant_child.minor).to eq(true)
  end
end
