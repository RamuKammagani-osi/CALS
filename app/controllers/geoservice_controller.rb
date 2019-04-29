# frozen_string_literal: true

class GeoserviceController < CalsBaseController
  def create
    @suggestion_suggest = geoservice_helper.suggest(params)
    render json: @suggestion_suggest
  end

  def validate
    post_data = request.body.read
    @suggestion_validate = geoservice_helper.validate(post_data)
    render json: @suggestion_validate
  end

  def geoservice_helper
    Helpers::GeoserviceHelper.new(auth_header: get_session_token)
  end
end
