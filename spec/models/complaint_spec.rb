# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec

describe Complaint do
  it 'builds a default complaint model' do
    complaint = FactoryBot.build(:complaint, code: 99_999)
    expect(complaint.code).to eq(99_999)
  end
end
