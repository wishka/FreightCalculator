# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  organization = Organization.create(name: 'Headmaster')
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  user = User.create!(email: 'admin_user@example.com', password: 'password', password_confirmation: 'password', organization_id: organization.id, role: 1)
  user_1 = User.create!(email: 'user_1@example.com', password: 'password', password_confirmation: 'password', organization_id: organization.id, role: 0)
  user_2 = User.create!(email: 'user_2@example.com', password: 'password', password_confirmation: 'password', organization_id: organization.id, role: 0)
  Shipment.create!(user: user_1, first_name: 'user_1', last_name: 'user_1_last', middle_name: 'user_1_middle', phone: '+79990123456',
                  email: 'user_1@example.com', weight: '10', length: '10', width: '10', height: '10', origin: 'Las Vegas', destination: 'New Jersy')
  Shipment.create!(user: user_1, first_name: 'user_1', last_name: 'user_1_last', middle_name: 'user_1_middle', phone: '+79990123456',
                  email: 'user_1@example.com', weight: '5', length: '6', width: '12', height: '7', origin: 'Las Vegas', destination: 'New York')
  Shipment.create!(user: user_1, first_name: 'user_1', last_name: 'user_1_last', middle_name: 'user_1_middle', phone: '+79990123456',
                  email: 'user_1@example.com', weight: '7', length: '12', width: '3', height: '7', origin: 'Las Vegas', destination: 'Los Angeles')
  Shipment.create!(user: user_1, first_name: 'user_1', last_name: 'user_1_last', middle_name: 'user_1_middle', phone: '+79990123456',
                  email: 'user_1@example.com', weight: '15', length: '34', width: '13', height: '9', origin: 'Las Vegas', destination: 'San Francisco')
  Shipment.create!(user: user_1, first_name: 'user_1', last_name: 'user_1_last', middle_name: 'user_1_middle', phone: '+79990123456',
                  email: 'user_1@example.com', weight: '11', length: '1', width: '14', height: '9', origin: 'Las Vegas', destination: 'Santa Barbara')

  Shipment.create!(user: user_2, first_name: 'user_2', last_name: 'user_2_last', middle_name: 'user_2_middle', phone: '+79990123456',
                  email: 'user_2@example.com', weight: '10', length: '10', width: '10', height: '10', origin: 'New Jersy', destination: 'Las Vegas')
  Shipment.create!(user: user_2, first_name: 'user_2', last_name: 'user_2_last', middle_name: 'user_2_middle', phone: '+79990123456',
                  email: 'user_2@example.com', weight: '5', length: '6', width: '12', height: '7', origin: 'New Jersy', destination: 'New York')
  Shipment.create!(user: user_2, first_name: 'user_2', last_name: 'user_2_last', middle_name: 'user_2_middle', phone: '+79990123456',
                  email: 'user_2@example.com', weight: '7', length: '12', width: '3', height: '7', origin: 'New Jersy', destination: 'Los Angeles')
  Shipment.create!(user: user_2, first_name: 'user_2', last_name: 'user_2_last', middle_name: 'user_2_middle', phone: '+79990123456',
                  email: 'user_2@example.com', weight: '15', length: '34', width: '13', height: '9', origin: 'New Jersy', destination: 'San Francisco')
  Shipment.create!(user: user_2, first_name: 'user_2', last_name: 'user_2_last', middle_name: 'user_2_middle', phone: '+79990123456',
                  email: 'user_2@example.com', weight: '11', length: '1', width: '14', height: '9', origin: 'New Jersy', destination: 'Santa Barbara')
end