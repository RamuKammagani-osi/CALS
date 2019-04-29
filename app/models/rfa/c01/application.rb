# frozen_string_literal: true

class Rfa::C01::Application < CalsBase
  include Concerns::Rfa::C01::ApplicationC01ApiProtocolProvider
  attr_accessor :id, :child_identified, :identified_children, :application_county,
                :metadata

  def self.api_resource_path
    'rfa-1c-forms'
  end

  def self.parent_path
    'rfa-1a-forms'
  end
end
