# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec
describe Relationship do
  it 'builds a default relationship' do
    relationship = FactoryBot.build(:relationship, union_city: 'test city')
    expect(relationship.union_city).to eq('test city')
  end
end
