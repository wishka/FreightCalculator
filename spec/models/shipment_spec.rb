# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe 'after_create' do
    it 'sends notification to user' do
      create(:shipment)
      expect(SendNotifyWorker.jobs.size).to eq(1)
    end
  end

  describe 'after_update' do
    it 'sends notification to user when status is changed' do
      shipment = create(:shipment)
      shipment.approve
      expect(SendNotifyWorker.jobs.size).to eq(1)
    end

    it 'does not send notification to user when status is not changed' do
      shipment = create(:shipment)
      shipment.update(description: 'Updated description')
      expect(SendNotifyWorker.jobs.size).to eq(0)
    end
  end
end
