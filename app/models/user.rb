class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader 
  has_many :shipments

  def self.ransackable_attributes(auth_object = nil)
    ["email", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
