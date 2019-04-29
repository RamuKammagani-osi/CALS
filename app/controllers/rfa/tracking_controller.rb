# frozen_string_literal: true

class Rfa::TrackingController < CalsBaseController
  before_action -> { require_rfa_privilege(method(:edit)) }, only: [:edit]
  def index
    tracking_response = tracking_helper.create_tracking(params[:a01_id])
    redirect_to edit_rfa_a01_tracking_path(id: tracking_response['id'], a01_id: params[:a01_id])
  end

  def edit
    @user = user_from_session
    @rfa_application = rfa_application_helper.find_by_application_id(params[:a01_id])
    @tracking = tracking_helper.find_by_id(params[:id])
  end

  def update
    @tracking_id = params[:id]
    @application_id = params[:rfa_1a_id]
    tracking_helper.update(@tracking_id, params[:rfa_1a_id], tracking_params.to_json)
    render json: tracking_helper.find_by_id(@tracking_id)
  rescue ApiError => e
    render json: e.response, status: e.status
  end

  private

  def tracking_params
    params.require(:tracking).permit(:id, :facility_name, :license_number, :rfa_1a_id,
                                     tracking_documents: [
                                       facility_documents:
                                       [family_documents: [items: %i[title received_date notes checked]],
                                        tasks_and_trainings: [items: %i[title completed_date notes checked]],
                                        assessments: [items: %i[title submitted_date approved_date notes checked]]],
                                       people_documents: [:person_id, :person_name, :person_type,
                                                          person_documents: [
                                                            individual_documents: [items: %i[title start_date completed_date notes checked]],
                                                            trainings: [items: %i[title expiration_date notes checked]],
                                                            clearances: [items: %i[title start_date completed_date notes checked]]
                                                          ]]
                                     ])
  end

  def rfa_application_helper
    Helpers::Rfa::ApplicationHelper.new(auth_header: get_session_token)
  end

  def tracking_helper
    Helpers::Rfa::TrackingHelper.new(auth_header: get_session_token)
  end
end
