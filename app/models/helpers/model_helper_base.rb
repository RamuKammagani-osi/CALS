# frozen_string_literal: true

class Helpers::ModelHelperBase
  include ActiveModel::Model

  attr_accessor :model_class
  attr_accessor :auth_header

  def initialize(args = {})
    self.auth_header = args[:auth_header]
  end

  def find_by_id(id)
    model_class.find_by_id(id, auth_header)
  end

  def all
    model_class.all(auth_header)
  end

  def create(parent_id, body)
    model_class.create(auth_header, parent_id, body)
  end

  def update(parent_id, body)
    model_class.update(auth_header, parent_id, body)
  end

  def delete(parent_id, id)
    model_class.delete(auth_header, parent_id, id)
  end

  def find_by_application_id(parent_id)
    model_class.find_by_application_id(auth_header, parent_id)
  end

  def find_items_by_application_id(parent_id)
    model_class.find_items_by_application_id(auth_header, parent_id)
  end
end
