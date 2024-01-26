Rails.application.routes.draw do
  root 'shipments#new'
  resources :shipments, only: %i[new create show index]
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
