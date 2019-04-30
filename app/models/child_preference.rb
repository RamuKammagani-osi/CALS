# frozen_string_literal: true

class ChildPreference < CalsBase
  include Concerns::ChildPreferenceApiProtocolProvider
  attr_accessor :sibling_group_size, :age_group_preference
end
