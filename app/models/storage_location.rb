class StorageLocation < ApplicationRecord
  belongs_to :restaurant
  validates :name, :address, :capacity, :temperature, :restaurant, presence: true
end
