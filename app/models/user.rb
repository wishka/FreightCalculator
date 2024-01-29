# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_many :shipments
  belongs_to :organization
  enum role: %i[operator organization_admin]
  after_initialize :set_default_role, if: :new_record?

  def self.ransackable_attributes(_auth_object = nil)
    %w[email id remember_created_at reset_password_sent_at reset_password_token updated_at]
  end

  private

  def set_default_role
    if @user == User.first
      self.role = :organization_admin
    else
      self.role ||= :operator
    end
  end
end
