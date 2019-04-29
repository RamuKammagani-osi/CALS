# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec

describe Inspection do
  it 'builds a default inspection model' do
    inspection = FactoryBot.build(:inspection, id: 77_777)
    expect(inspection.id).to eq(77_777)
  end
end
