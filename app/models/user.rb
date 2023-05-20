class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :notes
  has_many :purchasing_requests
  POSITIONS = %w[manager owner]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :phone_number, numericality: true
  validates :position, inclusion: { in: POSITIONS }
  has_many :notifications, as: :recipient, dependent: :destroy
end
