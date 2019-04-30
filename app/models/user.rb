# frozen_string_literal: true

class User < CalsBase
  attr_accessor :user, :first_name, :last_name, :staffId, :roles, :county_code, :county_name, :privileges

  #   def initialize(user, staffId, roles, county_code, county_name, privilege)
  #      @user = user
  #      @staffId = staffId
  #      @roles = roles
  #      @county_code = county_code
  #      @county_name = county_name
  #      @privilege = privilege
  #   end
end
