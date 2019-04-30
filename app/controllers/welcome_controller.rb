# frozen_string_literal: true

class WelcomeController < CalsBaseController
  before_action -> { require_rfa_privilege(method(:index)) }, only: [:index]
  def index
    @applications = rfa_application_helper.all_expanded
    @check_for_priviliges = check_for_priviliges.select { |service| service if service['id'] == 'facility_search' }
  end

  def create; end

  private

  def rfa_application_helper
    Helpers::Rfa::ApplicationHelper.new(auth_header: get_session_token)
  end
end
