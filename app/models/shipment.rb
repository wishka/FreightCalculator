require_relative 'calc_distance'

class Shipment < ApplicationRecord
  validates :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :origin, :destination, presence: true
  belongs_to :user, dependent: :destroy

  def calculate_distance
    url = "https://api.distancematrix.ai/maps/api/distancematrix/json?origins=#{@origin}&destinations=#{@destination}&key=Q4SHo8CIVXasF64BJVO7rsmS0czrg8ZLyrtd08IHcNO4p46k8OCu0tnPGPGPjK8R"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    if data && data['rows'] && data['rows'][0] && data['rows'][0]['elements'] && data['rows'][0]['elements'][0] && data['rows'][0]['elements'][0]['distance'] && data['rows'][0]['elements'][0]['distance']['value']
      distance = data['rows'][0]['elements'][0]['distance']['value']
      return distance
    else
      # Handle the case when the data is not in the expected format
      return nil
    end
  end

  def calculate_price
    calculator = DistCalculator.new(weight, length, width, height, origin, destination)
    calculator.calculate_price
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "destination", "email", "first_name", "height", "id", "last_name", "length", "middle_name", "origin", "phone", "updated_at", "weight", "width"]
  end
end