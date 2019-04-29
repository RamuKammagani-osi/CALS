# frozen_string_literal: true

class Rfa::ApplicationChildDesired < CalsBase
  include Concerns::Rfa::ApplicationChildDesiredApiProtocolProvider

  attr_accessor :child_identified, :child_in_home, :preferred_ages, :preferred_sibling_group_up_to

  def self.parent_path
    'rfa-1a-forms'
  end

  def self.api_resource_path
    'child-desired'
  end
end
