# frozen_string_literal: true

class Relationship < CalsBase
  attr_accessor :relationship_type, :union_date, :union_city,
                :term_reason, :term_date, :term_city, :term_state,
                :legal_first, :legal_middle, :legal_last

  # has_many :applicants
  #
  #

  # relationship history will be by term reason/date being present
end
