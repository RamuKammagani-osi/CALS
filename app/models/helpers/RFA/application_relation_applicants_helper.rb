# frozen_string_literal: true

class Helpers::Rfa::ApplicationRelationApplicantsHelper < Helpers::ModelHelperBase
  def model_class
    Rfa::RelationBetweenApplicant
  end

  def self.parent_path
    'rfa-1a-forms'
  end

  def self.api_resource_path
    'applicants-relationship'
  end
end
