# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

describe Rfa::A01Controller do
  before(:each) do
    allow(controller).to receive_messages(authenticate_with_cwds: true)
  end

  describe 'Post call' do
    #     it 'makes a application and returns its id' do
    #       post :create
    #
    #       expect(response.status).to eq(302)
    #       #redirect was successfull
    #     end
  end

  describe 'get call' do
    #     it 'renders the edit page' do
    #       application_helper = Helpers::Rfa::ApplicationHelper.new(auth_header: session['token'])
    #       rfa_application_response = application_helper.create_application
    #     end
  end

  # describe 'get edit' do
  #   it 'renders the edit page' do
  #     application_helper = Helpers::Rfa::ApplicationHelper.new(auth_header: session['token'])
  #     rfa_application_response = application_helper.create_application
  #
  #    get :edit, {params: {id: rfa_application_response['id']}}
  #    expect(response).to render_template('edit')
  #   end
  # end
end
