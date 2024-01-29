# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
  end

  def login_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = FactoryBot.create(:admin)
      sign_in :user, admin # sign_in(scope, resource)
    end
  end

  def login_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
