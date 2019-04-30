# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

describe Rfa::B01Controller, set_auth_header: true do
  before(:each) do
    allow(controller).to receive_messages(authenticate_with_cwds: true)
  end

  describe 'get edit' do
    it 'renders the edit page' do
      b01_application_helper = Helpers::Rfa::B01::ApplicationHelper.new(auth_header: ENV['TOKEN'])
      a01_application_helper = Helpers::Rfa::ApplicationHelper.new(auth_header: ENV['TOKEN'])
      rfa_01a_application_response = a01_application_helper.create_application
      rfa_01b_application_response = b01_application_helper.create_application(rfa_01a_application_response['id'], 519, 'applicants')
      get :edit, params: { id: 519, application_id: rfa_01a_application_response['id'] }
      expect(response).to render_template('edit')
    end
  end
end
