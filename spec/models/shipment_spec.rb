# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipment, type: :model do
  let(:user) { Shipment.new }

  describe 'state machine' do
    it 'initial state should be pending' do
      expect(your_instance.state).to eq('pending')
    end

    it 'should transition to approved state after approve event' do
      your_instance.approve
      expect(your_instance.state).to eq('approved')
    end

    it 'should transition to rejected state after reject event' do
      your_instance.reject
      expect(your_instance.state).to eq('rejected')
    end
  end

  describe 'notification mailer' do
    it 'should send approval notification after approve event' do
      expect(NotificationMailer).to receive(:approval_notification).with(your_instance).and_return(double(deliver_later: true))
      your_instance.approve
    end

    it 'should send rejection notification after reject event' do
      expect(NotificationMailer).to receive(:rejection_notification).with(your_instance).and_return(double(deliver_later: true))
      your_instance.reject
    end
  end

  describe 'send_approval_notification' do
    it 'should send approval notification' do
      expect(your_instance).to receive(:send_approval_notification)
      your_instance.send_approval_notification
    end
  end

  describe 'send_rejection_notification' do
    it 'should send rejection notification' do
      expect(your_instance).to receive(:send_rejection_notification)
      your_instance.send_rejection_notification
    end
  end
end
