class Wine < ApplicationRecord
  has_many :storage_locations, through: :restaurant
  belongs_to :supplier
  belongs_to :restaurant
  validates :maker, :country, :vintage, :colour, :region, :appellation, :volume, :cuvee, presence: true
end
