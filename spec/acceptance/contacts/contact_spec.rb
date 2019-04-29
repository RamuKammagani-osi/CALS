# frozen_string_literal: true

require 'rails_helper'
require 'vcr'
require 'faker'

RSpec.feature 'Contact', js: true, set_auth_header: true, inaccessible: true do
  before(:each) do
    visit root_path
    page.driver.browser.manage.window.resize_to 1200, 800
    click_button 'Create RFA Application'
    fill_in('applicants[0].first_name', with: 'James', match: :prefer_exact)
    fill_in('applicants[0].last_name', with: '0123Mont', match: :prefer_exact)
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
    sleep(3.seconds)
    click_link 'RFA Application list'
    expect(page).to have_content('0123Mont, James')
    page.find('a', text: '0123Mont, James', match: :first).find(:xpath, '..//..', match: :first).find('a', text: 'Profile link').click
    expect(page).to have_content '+ CREATE A NEW CONTACT'
    click_button '+ CREATE A NEW CONTACT'
  end

  scenario 'visit new contact page from dashboard and save' do
    expect(page).to have_content 'you can create a new contact to memorialize service and communication with a client and anyone affiliated with the client.'
    expect(page).to have_button 'Save'
    expect(page).to have_button 'Cancel'

    fill_in('dateOfContact', with: '11/20/1990', match: :prefer_exact)
    find('#contactClassificationYes').click
    select 'Email', from: 'methodOfContact'
    select 'Office', from: 'contactLocation'
    select 'Other', from: 'contactType'
    find('#contactNoticeYes').click
    find('#collateralVisitYes').click

    fill_in('startTime', with: '12132000', match: :prefer_exact)
    find('#startTime').send_keys :down
    fill_in('endTime', with: '11132000', match: :prefer_exact)
    find('#endTime').send_keys :down
    fill_in('contactTitle', with: 'contact title', match: :prefer_exact)
    fill_in('contactNotes', with: 'contact notes', match: :prefer_exact)

    click_button 'Save'
    expect(find_field('dateOfContact').value).to eq '11/20/1990'
    expect(find_field('contactClassificationtrue').value).to eq 'true'
    expect(find_field('methodOfContact').value).to eq '3'
    expect(find_field('contactLocation').value).to eq '1'
    expect(find_field('contactType').value).to eq '13'

    expect(find_field('contactNoticetrue').value).to eq 'true'
    expect(find_field('contactNoticetrue').value).to eq 'true'
    expect(find_field('startTime').value).to eq '12:13:20'
    expect(find_field('endTime').value).to eq '23:13:20'

    expect(find_field('contactTitle').value).to eq 'contact title'
    expect(find_field('contactNotes').value).to eq 'contact notes'
  end

  it 'visit new contact page from dashboard and cancel' do
    fill_in('contactTitle', with: 'contact title', match: :prefer_exact)
    fill_in('contactNotes', with: 'contact notes', match: :prefer_exact)
    click_button 'Cancel'
    expect(find_field('contactTitle').value).to eq ''
    expect(find_field('contactNotes').value).to eq ''
  end
end
