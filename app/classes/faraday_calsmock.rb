# frozen_string_literal: true

class FaradayCalsmock < Faraday::FaradayBase
  self.base_url = CALS_API_BASE_URL
end
