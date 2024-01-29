# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    role { :organization_admin }
  end

  trait :operator do
    role { :operator }
  end
end
