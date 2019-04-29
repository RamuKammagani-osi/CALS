# frozen_string_literal: true

# customizable error class
class ApiError < StandardError
  attr_reader :status
  attr_reader :response
  attr_reader :url
  def initialize(response = 'My default response', status = 200, url = 'url')
    @status = status
    @response = JSON.parse(response)
    @url = url
  end
end
