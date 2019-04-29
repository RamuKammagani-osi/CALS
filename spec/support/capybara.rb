# frozen_string_literal: true

require 'capybara/rspec'
require 'capybara/accessible'
require 'capybara-screenshot/rspec'
require 'selenium/webdriver'

def selenium_browser
  ENV.fetch('SELENIUM_BROWSER', 'chrome').downcase.to_sym
end

def remote_capabilities
  # app host is used to test against the app deployed to a remote URL
  # for example web.preint....
  if capybara_app_host.present?
    Capybara.app_host = capybara_app_host.to_s

    # for testing against deployed app, CAPYBARA_APP_PORT is not needed
    # port is used for IE testing against code running on development machine
    if capybara_app_port.present?
      Capybara.app_host =  "#{Capybara.app_host}:#{capybara_app_port}"
      Capybara.server_host = '0.0.0.0'
      Capybara.server_port = capybara_app_port
    else
      Capybara.run_server = false
    end
  end
end

def capybara_app_host
  ENV['CAPYBARA_APP_HOST']
end

def capybara_app_port
  ENV['CAPYBARA_APP_PORT']
end

def register_internet_explorer
  Capybara.register_driver selenium_browser do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.internet_explorer(
      native_events: false,
      javascript_enabled: true,
      version: 11
    )
    setup_driver(app, url: "http://#{selenium_server}/wd/hub",
                      capabilities: capabilities)
  end
  Capybara.javascript_driver = selenium_browser
end

def setup_driver(app, browser: selenium_browser, url: nil, options: nil, capabilities: {})
  driver = Capybara::Selenium::Driver.new(app,
                                          browser: browser,
                                          options: options,
                                          desired_capabilities: capabilities)
  driver.url = url if url.present?
  driver
end

def selenium_server
  ENV.fetch('SELENIUM_SERVER', 'localhost:4444')
end

def register_browser(browser, options = {})
  Capybara.register_driver :accessible_selenium do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.new(accept_insecure_certs: true)

    driver = setup_driver(app, browser: browser, options: options, capabilities: capabilities)
    setup_accessibility(driver)
  end
  Capybara.javascript_driver = :accessible_selenium
end

def setup_accessibility(driver)
  Capybara::Accessible.setup(driver, adaptor)
end

def adaptor
  Capybara::Accessible::SeleniumDriverAdapter.new
end

remote_capabilities

# wait increased to 5 seconds to avoid random failures.
# default wait is 2 seconds.
Capybara.default_max_wait_time = 5

case selenium_browser
when :chrome
  options = ::Selenium::WebDriver::Chrome::Options.new
  register_browser(:chrome, options)

when :headless_chrome
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.args.merge(%w[headless disable-gpu no-sandbox])
  register_browser(:chrome, options)

when :firefox
  register_browser(:firefox)

when :headless_firefox
  options = ::Selenium::WebDriver::Firefox::Options.new
  options.args.merge(%w[--headless --no-sandbox --disable-dev-shm-usage --window-size=1400,1400])

  register_browser(:firefox, options)

when :internet_explorer
  register_internet_explorer

else
  Capybara.javascript_driver = selenium_browser
end

Capybara.app = Rack::Builder.parse_file(File.expand_path('../../config.ru', __dir__)).first

module Capybara
  module Accessible
    class SeleniumDriverAdapter
      def modal_dialog_present?(driver)
        driver.browser.switch_to.alert
        true
      rescue ::Selenium::WebDriver::Error::UnhandledAlertError,
             ::Selenium::WebDriver::Error::NoSuchAlertError,
             ::NoMethodError
        false
      end
    end
  end
end
