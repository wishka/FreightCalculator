# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def approval_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Your shipment is approved!')
  end

  def rejection_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Your shipment is rejected!')
  end
end
