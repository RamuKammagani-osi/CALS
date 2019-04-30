# frozen_string_literal: true

class Reference < CalsBase
  attr_accessor :email_address, :legal_first, :legal_middle, :legal_last

  # has_one :address
  # has_one :phone
end
