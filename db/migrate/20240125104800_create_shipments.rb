# frozen_string_literal: true

class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :phone
      t.string :email
      t.float :weight
      t.float :length
      t.float :width
      t.float :height
      t.string :origin
      t.string :destination

      t.timestamps
    end
  end
end
