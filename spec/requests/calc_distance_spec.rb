# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DistCalculator do
  describe '#calculate_distance' do
    it 'returns the distance between the origin and destination' do
      calculator = DistCalculator.new(10, 100, 100, 100, 'Origin', 'Destination')
      allow(Net::HTTP).to receive(:get).and_return('{"rows":[{"elements":[{"distance":{"value":1000}}]}]}')

      distance = calculator.calculate_distance

      expect(distance).to eq(1000)
    end

    it 'returns nil if the data is not in the expected format' do
      calculator = DistCalculator.new(10, 100, 100, 100, 'Origin', 'Destination')
      allow(Net::HTTP).to receive(:get).and_return('{"rows":[]}')

      distance = calculator.calculate_distance

      expect(distance).to be_nil
    end
  end

  describe '#calculate_price' do
    it 'calculates the price based on the distance, volume, and weight' do
      calculator = DistCalculator.new(10, 100, 100, 100, 'Origin', 'Destination')
      allow(calculator).to receive(:calculate_distance).and_return(1000)

      price = calculator.calculate_price

      expect(price[:price]).to eq(1000)
    end
  end
end
