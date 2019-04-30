# frozen_string_literal: true

class DictionaryBase < CalsBase
  include Concerns::BaseCalsApiProtocolProvider

  attr_accessor :id, :value

  def self.api_resource_path
    # will convert
    # Dictionaries::RaceType = 'dictionaries/race-types'
    name.underscore.dasherize.pluralize.to_s
  end
end
