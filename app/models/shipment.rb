# frozen_string_literal: true

require_relative 'calc_distance'

class Shipment < ApplicationRecord
  include AASM

  aasm do
    state :pending, initial: true
    state :approved, :rejected

    after_all_transitions :notify_somebody

    event :approve do
      transitions from: :pending, to: :approved
      after do
        NotificationMailer.approval_notification(self).deliver_later
      end
    end

    event :reject do
      transitions from: :pending, to: :rejected
      after do
        NotificationMailer.rejection_notification(self).deliver_later
      end
    end
  end

  validates :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :origin,
            :destination, presence: true
  belongs_to :user, dependent: :destroy
  paginates_per 5

  def calculate_price
    calculator = DistCalculator.new(weight, length, width, height, origin, destination)
    calculator.calculate_price
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at destination email first_name height id last_name length middle_name
       origin phone updated_at weight width aasm_state]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  private

  def send_approval_notification
    SendNotifyWorker.perform_async(user_id, id)
  end

  def send_rejection_notification
    SendNotifyWorker.perform_async(user_id, id)
  end
end
