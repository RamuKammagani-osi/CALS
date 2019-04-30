# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes scope', type: :request do
  before(:each) do
    # allow(controller).to receive_messages(:authenticate_with_cwds => true)
    allow_any_instance_of(CalsBaseController).to receive(:authenticate_with_cwds).and_return(true)
    allow_any_instance_of(CalsBaseController).to receive(:get_session_token).and_return(ENV['TOKEN'])
    allow_any_instance_of(CalsBaseController).to receive(:check_for_priviliges).and_return(['Something Privilige'])
    $redis.flushdb
  end

  context 'with custom relative url' do
    let(:app) do
      Rack::Builder.parse_file(File.expand_path('../../config.ru', __dir__)).first
    end

    # let!(:redis) { MockRedis.new }

    # before(:context) do
    #  @tmp_env_var = ENV['RAILS_RELATIVE_URL_ROOT']
    #  ENV['RAILS_RELATIVE_URL_ROOT']='/cals'
    #  $redis.flushdb
    # end

    it 'redirects requests' do
      get '/facilities/300665437'
      expect(response).to have_http_status(200)
    end

    it 'does not raise error' do
      expect { get '/facilities/300665437' }.not_to raise_error
    end

    after(:context) do
      @app = nil
      # ENV['RAILS_RELATIVE_URL_ROOT'] = @tmp_env_var
    end
  end

  context 'without custom relative url' do
    before(:each) do
      allow_any_instance_of(CalsBaseController).to receive(:authenticate_with_cwds).and_return(true)
      allow_any_instance_of(CalsBaseController).to receive(:get_session_token).and_return(ENV['TOKEN'])
      $redis.flushdb
    end

    it 'redirects requests' do
      get '/facilities/300665437'
      expect(response).to have_http_status(200)
    end
  end
end
