# frozen_string_literal: true

Rails.application.routes.draw do
  root 'shipments#new'
  resources :shipments, only: %i[new create show index]
  devise_for :users
  resources :organizations
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
