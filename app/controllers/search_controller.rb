# frozen_string_literal: true

class SearchController < CalsBaseController
  before_action -> { require_search_privilege(method(:index)) }
  include Response

  def index; end

  def search_dictionaries
    dictionaries = dictionaries_helper.facilities_dictionaries
    search_dictionaries = {}
    search_dictionaries['countyTypes'] = dictionaries[:county_types]
    search_dictionaries['facilityTypes'] = dictionaries[:facility_types]
    search_dictionaries['licenseStatuses'] = dictionaries[:license_status_types]
    json_response search_dictionaries
  end

  def user_data
    user = user_from_session
    json_response user
  end

  private

  def dictionaries_helper
    Helpers::Dictionary.new(auth_header: get_session_token)
  end
end
