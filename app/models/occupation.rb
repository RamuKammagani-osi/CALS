# frozen_string_literal: true

class Occupation < CalsBase
  attr_accessor :employer_name, :job_title, :income, :income_freq
  # has_one :address
end
