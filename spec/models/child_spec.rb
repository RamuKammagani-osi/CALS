# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec

describe Child do
  it 'builds a default child model' do
    child = FactoryBot.build(:child, name: 'test')
    expect(child.name).to eq('test')
  end
end
