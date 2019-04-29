# frozen_string_literal: true

class Geoservice < CalsBase
  include Concerns::GeoserviceApiProtocolProvider
  attr_accessor :street_address, :city, :state, :zip, :zip_extension,
                :longitude, :lattitude, :deliverable, :state_abbreviation

  def self.api_resource_path
    'address'
  end
end
