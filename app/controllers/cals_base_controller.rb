# frozen_string_literal: true

class CalsBaseController < ApplicationController
  include AuthenticationProvider
  include RedisHelper
  before_action :authenticate_with_cwds # , unless: 'Rails.env.development?'
  helper_method :user_from_session

  def logout
    delete_user_from_session
    default_callback_url = ''
    login_url = Cwds::Authentication.authentication_url(AUTHENTICATION_API_BASE_URL, default_callback_url)
    redirect_to Cwds::Authentication.logout_url(AUTHENTICATION_API_BASE_URL, login_url)
  end

  def user_from_session
    User.new(JSON.parse(session[:user_details])) if session[:user_details].present?
  end

  private

  def check_for_priviliges
    @content = Content::ContentService.new.filter_content(user_from_session)
    @content[:services]
  end

  def require_rfa_privilege(method)
    rfa_service = check_for_priviliges.select { |service| service if service['id'] == 'cals_rfa' }
    if !rfa_service.empty?
      method
    else
      render 'errors/forbidden_page'
    end
  end

  def require_search_privilege(method)
    search_service = check_for_priviliges.select { |service| service if service['id'] == 'facility_search' }
    if !search_service.empty?
      method
    else
      render 'errors/forbidden_page'
    end
  end

  protected

  def authenticate_with_cwds
    token = Cwds::Authentication.token_generation(params[:accessCode], AUTHENTICATION_API_BASE_URL)
    session.delete(:token) if token.present?
    if session[:token].blank?
      if Cwds::Authentication.token_validation(token, AUTHENTICATION_API_BASE_URL)
        store_token_in_redis(token)
      else
        redirect_to Cwds::Authentication.authentication_url(AUTHENTICATION_API_BASE_URL, request.url)
        return
      end
    end
    session[:user_details] = Cwds::Authentication.store_user_details_from_token(session[:token]) if session[:user_details].nil?
  end
end
