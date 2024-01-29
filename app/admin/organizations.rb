# frozen_string_literal: true

ActiveAdmin.register Organization do
  index do
    selectable_column
    id_column
    column :name
    column :operator
  end

  permit_params :name, :operator
end
