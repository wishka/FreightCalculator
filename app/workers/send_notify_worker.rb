# frozen_string_literal: true

class SendNotifyWorker
  include Sidekiq::Worker

  def perform(user_id, message)
    user = User.find(user_id)
    UserMailer.with(user: user, message: message).notification_email.deliver_now
  end
end
