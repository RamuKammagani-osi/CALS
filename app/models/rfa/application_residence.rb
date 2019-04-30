# frozen_string_literal: true

class Rfa::ApplicationResidence < CalsBase
  include Concerns::Rfa::ApplicationResidenceApiProtocolProvider

  # attr_accessor :property_type, :own_rent_lease,
  #   :weapons, :body_of_water, :directions

  attr_accessor :addresses

  attr_accessor :physical_mailing_similar,
                :residence_ownership, :weapon_in_home, :body_of_water_exist,
                :body_of_water_description, :directions_to_home, :home_languages, :validation_details

  attr_accessor :others_using_residence_as_mailing, :other_people_using_residence_as_mailing

  # has_many :non_residents

  # has_many :addresses

  def addresses=(val)
    @addresses = val.map { |itm| Address.new(itm) } if val.present?
  end

  # methods

  def self.parent_path
    'rfa-1a-forms'
  end

  def self.api_resource_path
    'residence'
  end
end
