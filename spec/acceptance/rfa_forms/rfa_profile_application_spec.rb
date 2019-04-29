# frozen_string_literal: true

require 'rails_helper'
require 'vcr'
require 'faker'

RSpec.feature 'Profile', js: true, inaccessible: true do
  before do
    visit root_path
    click_button 'Create RFA Application'
    fill_in('applicants[0].first_name', with: 'James', match: :prefer_exact)
    fill_in('applicants[0].last_name', with: '0123Monteo', match: :prefer_exact)
    fill_in('applicants[0].date_of_birth', with: '11/11/1986', match: :prefer_exact)
    select 'Male', from: 'applicants[0].gender'
    expect(page).to have_content 'Phone Number'
    fill_in 'applicants[0].phones[0].number', with: '201-222-2345'
    page.find('#residentAddress').fill_in('Residentialstreet_address', with: '2870 something else', match: :prefer_exact)
    page.find('#residentAddress').fill_in('Residentialzip', with: '12345', match: :prefer_exact)
    page.find('#residentAddress').fill_in('Residentialcity', with: 'Sacremento', match: :prefer_exact)
    find('#react-select-3--value').click
    find('#react-select-3--option-5').click
    find('#mailing_similarYes').click
    expect(page).to have_content 'About This Residence'
    select 'Own', from: 'residenceTypes'
    find('#weaponsYes').click
    find('#body_of_water_existNo').click
    find('#others_using_residence_as_mailingNo').click
    page.find(:css, '.languages').click
    page.find(:css, '#react-select-2--option-0').click
    page.find(:css, '.languages').click
    page.find(:css, '#react-select-2--option-1').click
    click_button 'Save Progress'
    click_button 'Submit'
    click_link 'RFA Application list'
    expect(page).to have_content('123Monteo, James')
    expect(page).to have_content('Submitted')
    page.find('a', text: '0123Monteo, James', match: :first).find(:xpath, '..//..', match: :first).find('a', text: 'Profile link').click
  end

  scenario 'visit Profile page from dashboard', set_auth_header: true do
    expect(page).to have_content 'tracking link'
  end
end
