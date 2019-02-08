ENV['RAILS_ENV'] = 'test'

require 'simplecov'
require 'mock_redis'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# ActiveRecord::Migration.maintain_test_schema!

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:each, :set_auth_header => true) do
    if ENV['TEST_END_TO_END']
      visit root_path
      fill_in_login()
    else
      stub_auth_tokens
    end
  end

  config.around(:each, inaccessible: true) do |example|
    Capybara::Accessible.skip_audit { example.run }
  end

  config.after(:each, type: :feature) do
    page.execute_script 'sessionStorage.clear()'
  end

  def fill_in_login
    if ENV['CAPYBARA_APP_HOST'].include?('preint')
      if page.has_content?('Sign In')
        fill_in('username', with: USERNAME)
        # fill_in('password', with: PASSWORD)
        click_button 'Sign In'
      end
    else
      return unless need_login?
      Capybara.fill_in('Email', with: ENV['ACCEPTANCE_TEST_USER'])
      Capybara.fill_in('Password', with: ENV['ACCEPTANCE_TEST_PASSWORD'])
      if %i[selenium_ie selenium_edge].include?(Capybara.current_driver)
        Capybara.execute_script('document.getElementsByTagName("button")[0].click()')
      else
        Capybara.click_button('Sign In')
      end
      multi_factor_auth
    end
  end

  def multi_factor_auth
    return unless mfa_page?
    Capybara.fill_in('Verification Code', with: ENV['VERIFICATION_CODE'])
    if %i[selenium_ie selenium_edge].include?(Capybara.current_driver)
      Capybara.execute_script('document.getElementById("validateButton").click()')
    else
      Capybara.click_button('Verify')
    end
    find('button', text: 'SEARCH FOR FACILITY')
  end

  def mfa_page?
    Capybara.current_url.include?('login')
  end

  def need_login?
    !page.has_content?('SEARCH FOR FACILITY', wait: 5)
  end

  def stub_auth_tokens
    allow_any_instance_of(CalsBaseController).to receive(:user_from_session).and_return(FactoryBot.build(:user))
    allow_any_instance_of(CalsBaseController).to receive(:authenticate_with_cwds).and_return(true)
    allow_any_instance_of(CalsBaseController).to receive(:get_session_token).and_return(ENV['TOKEN'])
    allow_any_instance_of(CalsBaseController).to receive(:store_token_in_redis).and_return(ENV['TOKEN'])
  end

  # VCR Config
  unless ENV['TEST_END_TO_END'] || ENV['DISABLE_VCR']
    config.around(:each) do |example|
      options = example.metadata[:vcr] || {}
      if options[:record] == :skip
        VCR.turned_off(&example)
      else
        name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(/\./, '/').gsub(/[^\w\/]+/, '_').gsub(/\/$/, '')
        VCR.use_cassette(name, options, &example)
      end
    end
  end

end
