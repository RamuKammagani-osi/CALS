# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

describe Rfa::C01Controller, set_auth_header: true do
  before(:each) do
    allow(controller).to receive_messages(authenticate_with_cwds: true)
  end

  describe '#index' do
    it 'redirects to edit' do
      application_helper = Helpers::Rfa::ApplicationHelper.new(auth_header: ENV['TOKEN'])
      rfa_application_response = application_helper.create_application

      post :index, params: { a01_id: rfa_application_response['id'] }
      expect(response.status).to eq(302)
    end
  end

  describe 'get edit' do
    it 'renders the edit page' do
      application_helper = Helpers::Rfa::ApplicationHelper.new(auth_header: ENV['TOKEN'])
      rfa_application_response = application_helper.create_application

      c01_application_helper = Helpers::Rfa::C01::ApplicationHelper.new(auth_header: ENV['TOKEN'])
      rfa_c01_app_response = c01_application_helper.create(rfa_application_response['id'], '{}')

      get :edit, params: { a01_id: rfa_application_response['id'], id: rfa_c01_app_response.id }
      expect(response).to render_template('edit')
    end
  end
end
