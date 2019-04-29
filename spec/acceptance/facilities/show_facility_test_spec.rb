# frozen_string_literal: true

require 'rails_helper'
require 'vcr'

RSpec.feature 'Facility Search & Profile', js: true, set_auth_header: true do
  before(:each) do
    allow_any_instance_of(SearchController).to receive(:user_from_session).and_return(FactoryBot.build(:user))
  end

  scenario 'To get list of facilities from search results' do
    facilities_list
  end

  scenario 'To click toggle result and validate facility name in list view' do
    facilities_list
    within(:css, '.toggle_result') do
      page.find(:css, '.line_off-icon.navbar-brand').click
    end
    expect(page).to have_text('Facility Type / Facility Source')
  end

  scenario 'To select county dropdown and show search results' do
    visit search_index_path
    select 'Alameda', from: 'county_select'
    find_button('Search').click
    expect(page).to have_content('Phone Number', minimum: 1)
  end

  scenario 'To select facility type dropdown and show search results' do
    visit search_index_path
    select 'Ventura', from: 'county_select'
    select 'Foster Family Home', from: 'facility_select'
    find_button('Search').click
    expect(page).to have_content('Phone Number', minimum: 1)
  end

  scenario 'To test dropdown for number of facilities per page' do
    facilities_list
    within(:css, '.advance-search') do
      select '10', from: 'noOfFacilities'
      expect(find_field('noOfFacilities').value).to eq '10'
    end
    expect(page).to have_content('Phone Number', minimum: 1)
  end

  def facilities_list
    visit search_index_path
    select 'Riverside', from: 'county_select'
    find_button('Search').click
  end
end
