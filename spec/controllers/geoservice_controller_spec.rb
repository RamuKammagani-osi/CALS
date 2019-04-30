# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

describe GeoserviceController do
  before(:each) do
    allow(controller).to receive_messages(authenticate_with_cwds: true)
  end

  describe 'GET create' do
    it 'renders create' do
      post :create, params: { _json: '1%20gateway' }
      expect(response.status).to eq(200)
    end
  end
end
