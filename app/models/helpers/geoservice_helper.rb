# frozen_string_literal: true

class Helpers::GeoserviceHelper < Helpers::ModelHelperBase
  def model_class
    Geoservice
  end

  def suggest(params)
    Geoservice.suggest(params, auth_header)
  end

  def lookup
    Geoservice.lookup(auth_header)
  end

  def validate(body)
    Geoservice.validate(auth_header, body)
  end
end
