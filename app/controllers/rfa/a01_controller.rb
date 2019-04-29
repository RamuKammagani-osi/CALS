# frozen_string_literal: true

class Rfa::A01Controller < CalsBaseController
  before_action -> { require_rfa_privilege(method(:edit)) }, only: [:edit]
  # include AuthenticationProvider

  def create
    # make api call to create application
    rfa_app_response = rfa_application_helper.create_application
    rfa_application = Rfa::Application.new
    rfa_application.id = rfa_app_response['id']
    render json: rfa_application
  end

  def edit
    # @all dictionaries
    @user = user_from_session
    @dictionaries = dictionaries_helper.rfa_a01_dictioniaries
    @application = rfa_application_helper.find_by_application_id(params[:id])
  end

  def update
    @application_id = params[:id]
    response = rfa_application_helper.update(@application_id, params[:a01].to_json)
    render json: response
  rescue ApiError => e
    render json: e.response, status: e.status
  end

  def submit
    @application_id = params[:id]
    rfa_application_helper.submit_application(@application_id)
    render json: rfa_application_helper.find_by_application_id(@application_id)
  rescue StandardError => e
    render json: e.response, status: e.status
  end

  private

  def rfa_application_helper
    Helpers::Rfa::ApplicationHelper.new(auth_header: get_session_token)
  end

  def dictionaries_helper
    Helpers::Dictionary.new(auth_header: get_session_token)
  end
end
