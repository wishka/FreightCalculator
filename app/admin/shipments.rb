ActiveAdmin.register Shipment do
  permit_params :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :origin, :destination
end