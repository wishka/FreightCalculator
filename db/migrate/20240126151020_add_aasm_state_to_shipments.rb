class AddAasmStateToShipments < ActiveRecord::Migration[7.0]
  def change
    add_column :shipments, :aasm_state, :string
  end
end
