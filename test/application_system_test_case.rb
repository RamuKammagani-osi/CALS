# frozen_string_literal: true

require 'test_helper'
require 'capybara/poltergeist'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :poltergeist, using: :PhantomJS
end
