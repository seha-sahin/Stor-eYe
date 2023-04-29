class Restaurant < ApplicationRecord
  has_many :wines
  has_many :storage_locations

  validates :phone_number, numericality: true
end
