# frozen_string_literal: true

class Rfa::ApplicationReference < CalsBase
  include Concerns::Rfa::ApplicationReferenceApiProtocolProvider

  attr_accessor :name_prefix, :first_name, :middle_name, :last_name, :name_suffix,
                :mailing_address, :phone_number, :email

  def self.parent_path
    'rfa-1a-forms'
  end

  def self.api_resource_path
    'references'
  end
end
