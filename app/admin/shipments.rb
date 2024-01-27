ActiveAdmin.register Shipment do
  index do
    column :first_name
    column :last_name
    column :middle_name
    column :phone
    column :email
    column :weight
    column :length
    column :width
    column :height
    column :origin
    column :destination
    state_column :aasm_state
  end
  filter :aasm_state, as: :select, collection: Shipment.aasm.states.map(&:name)
  form do |f|
    f.inputs 'Shipment Details' do
      # ...
      f.input :aasm_state, as: :select, collection: Shipment.aasm.states.map(&:name)
      # ...
    end
    f.actions
  end
  permit_params :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :origin, :destination, :aasm_state
end

