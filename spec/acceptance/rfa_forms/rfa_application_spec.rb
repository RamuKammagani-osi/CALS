# frozen_string_literal: true

require 'rails_helper'
require 'vcr'
require 'faker'

RSpec.feature 'RFA', js: true, inaccessible: true do
  scenario 'Dashboard page', set_auth_header: true do
    visit root_path
    expect(page).to have_button('Create RFA Application')
  end

  scenario 'validate applicant card', set_auth_header: true do
    visit root_path
    click_button 'Create RFA Application'
    expect(page).to have_content 'Applicant 1 - Information'
  end

  scenario 'validate scrollspy', set_auth_header: true do
    visit root_path
    click_button 'Create RFA Application'
    expect(page).to have_content 'Applicant 1 - Information'
  end
end
