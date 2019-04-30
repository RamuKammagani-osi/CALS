# frozen_string_literal: true

class FaradaySearch < Faraday::FaradayBase
  self.base_url = BASE_SEARCH_API_URL
end
