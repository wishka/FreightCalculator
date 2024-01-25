require 'json'
require 'net/http'

class FreightCalculator
  def initialize(weight, length, width, height, origin, destination)
    @weight = weight
    @length = length
    @width = width
    @height = height
    @origin = origin
    @destination = destination
  end

  def calculate_distance
    url = "https://api.distancematrix.ai/maps/api/distancematrix/json?origins=#{@origin}&destinations=#{@destination}&key=Q4SHo8CIVXasF64BJVO7rsmS0czrg8ZLyrtd08IHcNO4p46k8OCu0tnPGPGPjK8R"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    distance = data['rows'][0]['elements'][0]['distance']['value']
    distance
  end

  def calculate_price
    distance = calculate_distance
    volume = @length * @width * @height / 1000000.0 # convert cm^3 to m^3

    if volume < 1
      price = distance * 1
    elsif volume >= 1 && @weight <= 10
      price = distance * 2
    else
      price = distance * 3
    end

    { weight: @weight, length: @length, width: @width, height: @height, distance: distance, price: price }
  end
end

# Example usage:
calculator = FreightCalculator.new(10, 50, 40, 30, 'Origin', 'Destination')
result = calculator.calculate_price
puts result