# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

describe CalsBaseController do
  controller do
    def custom
      render json: true, status: :ok
    end
  end

  before do
    routes.draw do
      get 'custom' => 'cals_base#custom'
      get 'logout' => 'cals_base#logout'
    end
  end

  it 'sets token when token is empty' do
    profile_json = {
      'user': 'y_test111+role2@outlook.com',
      'roles': [
        'CWS-worker',
        'CWS-admin',
        'County-admin',
        'CANS-worker'
      ],
      'first_name': 'Mohammed',
      'last_name': 'Nasir',
      'email': 'y_test111+role2@outlook.com',
      'county_code': '20',
      'county_cws_code': 1087,
      'county_name': 'Madera',
      'privileges': [
        'Snapshot-rollout',
        'Facility-search-rollout',
        'development-not-in-use',
        'RFA-rollout',
        'Hotline-rollout',
        'CANS-rollout'
      ],
      'userName': 'd284bda7-9e7a-4967-b8b4-db80b87bc1e0'
    }

    hashed_profile_json = {
      user: 'y_test111+role2@outlook.com',
      roles: ['CWS-worker', 'CWS-admin', 'County-admin', 'CANS-worker'],
      first_name: 'Mohammed',
      last_name: 'Nasir',
      email: 'y_test111+role2@outlook.com',
      county_code: '20',
      county_cws_code: 1087,
      county_name: 'Madera',
      privileges: [
        'Snapshot-rollout',
        'Facility-search-rollout',
        'development-not-in-use',
        'RFA-rollout',
        'Hotline-rollout',
        'CANS-rollout'
      ],
      userName: 'd284bda7-9e7a-4967-b8b4-db80b87bc1e0'
    }

    allow(Cwds::Authentication).to receive(:token_generation)
      .with('dcba', ENV.fetch('AUTHENTICATION_API_BASE_URL')).and_return('abcd')
    allow(Cwds::Authentication).to receive(:token_validation)
      .with('abcd', ENV.fetch('AUTHENTICATION_API_BASE_URL')).and_return(true)
    allow(Cwds::Authentication).to receive(:store_user_details_from_token)
      .with('abcd').and_return(profile_json)
    get :custom, params: { accessCode: 'dcba' }
    expect(session[:token]).to eq('abcd')
    expect(session[:user_details]).to eq(hashed_profile_json)
  end

  it 'redirects when token invalid' do
    allow(Cwds::Authentication).to receive(:authentication_url).with(AUTHENTICATION_API_BASE_URL, 'http://test.host/custom').and_return('www.google.com')
    process :custom, method: :get
    expect(response).to redirect_to 'www.google.com'
  end

  it 'logs out the user' do
    allow_any_instance_of(CalsBaseController).to receive(:authenticate_with_cwds).and_return(true)
    allow(Cwds::Authentication).to receive(:authentication_url).with(AUTHENTICATION_API_BASE_URL, '').and_return('www.google.com')
    allow(Cwds::Authentication).to receive(:logout_url).with(AUTHENTICATION_API_BASE_URL, 'www.google.com').and_return('www.google.com/login')
    get :logout
    assert_redirected_to 'www.google.com/login'
  end
end
