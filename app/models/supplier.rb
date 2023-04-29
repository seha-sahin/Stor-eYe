class Supplier < ApplicationRecord
  has_many :purchasing_requests
  has_many :wines

  validates :phone_number, numericality: true
  validates :contact_phone_number, numericality: true
  validates :email, email: true
  validates :contact_email, email: true
end
