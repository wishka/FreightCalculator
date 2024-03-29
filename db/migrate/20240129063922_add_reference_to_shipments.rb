# frozen_string_literal: true

class AddReferenceToShipments < ActiveRecord::Migration[7.0]
  def change
    add_reference :shipments, :user, null: false, foreign_key: true
  end
end
