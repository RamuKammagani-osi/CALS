# frozen_string_literal: true

require 'rails_helper'
require 'vcr'
require 'faker'

RSpec.feature 'RFATracking', js: true, inaccessible: true do
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
    page.find('a', text: '0123Monteo, James', match: :first).find(:xpath, '..//..', match: :first).find('a', text: 'Profile link').click
    page.find('a', text: 'tracking link').click
  end

  scenario 'visit tracking page from dashboard', set_auth_header: true do
    expect(page).to have_content '-RFA Application'
  end

  scenario 'visit tracking page from dashboard ande save', set_auth_header: true do
    expect(page).to have_button 'Edit Checklist'
    click_button 'Edit Checklist'
    expect(page).to have_button 'Save'
    expect(page).to have_button 'Cancel'
  end

  scenario 'visit tracking page from dashboard and Edit', set_auth_header: true do
    expect(page).to have_button 'Edit Checklist'
    click_button 'Edit Checklist'
    expect(page).to have_button 'Save'
    expect(page).to have_button 'Cancel'
    fill_in('familyEditRecievedDate0', with: '12/01/1987', match: :prefer_exact)
    fill_in('familyEditNotes0', with: 'familyEditNotes0 test edit', match: :prefer_exact)
    fill_in('taskAndTrainingEditCompletedDate0', with: '12/02/1987', match: :prefer_exact)
    fill_in('taskAndTrainingEditNotes0', with: 'taskAndTrainingEditNotes0 test edit', match: :prefer_exact)
    fill_in('assessmentEditSubmittedDate0', with: '12/03/1987', match: :prefer_exact)
    fill_in('assessmentEditApprovedDate0', with: '12/04/1987', match: :prefer_exact)
    fill_in('assessmentEditText0', with: 'assessmentEditText0 test edit', match: :prefer_exact)
    click_button 'Save'
    expect(page).to have_content '12/01/1987'
    expect(page).to have_content 'familyEditNotes0 test edit'
    expect(page).to have_content '12/02/1987'
    expect(page).to have_content 'taskAndTrainingEditNotes0 test edit'
    expect(page).to have_content '12/03/1987'
    expect(page).to have_content '12/04/1987'
    expect(page).to have_content 'assessmentEditText0 test edit'
  end

  scenario 'visit tracking page from dashboard and cancel', set_auth_header: true do
    expect(page).to have_button 'Edit Checklist'
    click_button 'Edit Checklist'
    expect(page).to have_button 'Save'
    expect(page).to have_button 'Cancel'
    fill_in('familyEditRecievedDate0', with: '11/11/1987', match: :prefer_exact)
    fill_in('familyEditNotes0', with: 'familyEditNotes0 typo cancel', match: :prefer_exact)
    fill_in('taskAndTrainingEditCompletedDate0', with: '11/12/1987', match: :prefer_exact)
    fill_in('taskAndTrainingEditNotes0', with: 'taskAndTrainingEditNotes0 typo cancel', match: :prefer_exact)
    fill_in('assessmentEditSubmittedDate0', with: '11/13/1987', match: :prefer_exact)
    fill_in('assessmentEditApprovedDate0', with: '11/14/1987', match: :prefer_exact)
    fill_in('assessmentEditText0', with: 'assessmentEditText0 typo cancel', match: :prefer_exact)
    click_button 'Cancel'
    expect(page).not_to have_content '11/11/1987'
    expect(page).not_to have_content 'familyEditNotes0 typo cancel'
    expect(page).not_to have_content '11/12/1987'
    expect(page).not_to have_content 'taskAndTrainingEditNotes0 typo cancel'
    expect(page).not_to have_content '11/13/1987'
    expect(page).not_to have_content '11/14/1987'
    expect(page).not_to have_content 'assessmentEditText0 typo cancel'
  end

  scenario 'visit tracking page from dashboard and Edit Applicant Row', set_auth_header: true do
    expect(page).to have_button 'Edit Checklist'
    click_button 'Edit Checklist'
    expect(page).to have_button 'Save'
    expect(page).to have_button 'Cancel'
    fill_in('individual0EditStartDate0', with: '12/11/1987', match: :prefer_exact)
    fill_in('individual0EditApprovedDate0', with: '12/11/1987', match: :prefer_exact)
    fill_in('individual0EditText0', with: ' individual0EditText0 testing', match: :prefer_exact)
    fill_in('training0EditExpirationDate0', with: '12/12/1987', match: :prefer_exact)
    fill_in('training0EditText0', with: 'training0EditText0 testing', match: :prefer_exact)
    fill_in('clearance0EditStartDate0', with: '12/13/1987', match: :prefer_exact)
    fill_in('clearance0EditCompleteDate0', with: '12/14/1987', match: :prefer_exact)
    fill_in('clearance0EditText0', with: 'clearance0EditText0 testing', match: :prefer_exact)
    click_button 'Save'
    expect(page).to have_content '12/11/1987'
    expect(page).to have_content '12/11/1987'
    expect(page).to have_content 'individual0EditText0 testing'
    expect(page).to have_content '12/12/1987'
    expect(page).to have_content 'training0EditText0 testing'
    expect(page).to have_content '12/13/1987'
    expect(page).to have_content '12/14/1987'
    expect(page).to have_content 'clearance0EditText0 testing'
  end
  scenario 'visit tracking page from dashboard and Edit Other Adults Row', set_auth_header: true do
    expect(page).to have_button 'Edit Checklist'
    click_button 'Edit Checklist'
    expect(page).to have_button 'Save'
    expect(page).to have_button 'Cancel'
    fill_in('individual1EditStartDate0', with: '12/11/1997', match: :prefer_exact)
    fill_in('individual1EditApprovedDate0', with: '12/11/1997', match: :prefer_exact)
    fill_in('individual1EditText0', with: 'individual Other Adults Residing testing', match: :prefer_exact)
    fill_in('clearance1EditStartDate0', with: '12/13/1997', match: :prefer_exact)
    fill_in('clearance1EditCompleteDate0', with: '12/14/1997', match: :prefer_exact)
    fill_in('clearance1EditText0', with: 'clearance Other Adults Residing testing', match: :prefer_exact)
    click_button 'Save'
    expect(page).to have_content '12/11/1997'
    expect(page).to have_content '12/11/1997'
    expect(page).to have_content 'individual Other Adults Residing testing'
    expect(page).to have_content '12/13/1997'
    expect(page).to have_content '12/14/1997'
    expect(page).to have_content 'clearance Other Adults Residing testing'
  end

  scenario 'verify tracking sidebar render', set_auth_header: true do
    expect(page).to have_content 'Applicants'
    expect(page).to have_content 'James 0123Monteo'
    expect(page).to have_content 'Adults Residing in the Home'
    expect(page).to have_content 'Adults Regularly Present'
  end
end
