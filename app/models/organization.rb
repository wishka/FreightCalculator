# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users

  def self.ransackable_associations(_auth_object = nil)
    ['users']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end
end
