# frozen_string_literal: true

class FaradayGeoservice < Faraday::FaradayBase
  self.base_url = GEO_SERVICE_URL
end
