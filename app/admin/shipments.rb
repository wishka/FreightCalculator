# frozen_string_literal: true

ActiveAdmin.register Shipment do
  index do
    selectable_column
    id_column
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
  permit_params :aasm_state

  member_action :approve, method: :put do
    resource.approve!
    redirect_to admin_path(resource), notice: 'Shipment approved!'
  end
  member_action :reject, method: :put do
    resource.reject!
    redirect_to admin_path(resource), notice: 'Shipment rejected!'
  end

  # actions defaults: true do |shipment|
  #   link_to 'Approve', approve_admin_path(shipment), method: :put
  #   link_to 'Reject', reject_admin_path(shipment), method: :put
  # end

  form do |f|
    f.inputs 'Shipment Details' do
      # ...
      f.input :aasm_state, as: :select, collection: Shipment.aasm.states.map(&:name)
      # ...
    end
    f.actions
  end
  permit_params :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :origin,
                :destination, :aasm_state
end
