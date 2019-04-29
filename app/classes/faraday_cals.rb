# frozen_string_literal: true

class FaradayCals < Faraday::FaradayBase
  self.base_url = CALS_API_URL
end
