class Wine < ApplicationRecord
  has_many :storage_locations, through: :restaurant
  belongs_to :supplier
  belongs_to :restaurant
  validates :maker, :country, :vintage, :colour, :region, :appellation, :volume, :cuvee, presence: true

  acts_as_taggable_on :makers
  acts_as_taggable_on :countries
  acts_as_taggable_on :vintages
  acts_as_taggable_on :regions
  acts_as_taggable_on :appellations
  acts_as_taggable_on :cuvees

  def self.total_quantity
    total_quantity = 0
    Wine.all.each do |wine|
      total_quantity += wine.quantity
    end
    total_quantity
  end

  def self.total_value
    total_value = 0
    Wine.all.each do |wine|
      total_value += wine.unit_price
    end
    total_value
  end
end
