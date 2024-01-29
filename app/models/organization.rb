# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users

  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
