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
  acts_as_taggable_on :tastingnotes
  acts_as_taggable_on :grape_varieties


  VOLUMES = %w[Bottle Magnum Half-bottle]
  COLOURS = %w[Sparkling White Red Rose Sweet Oxydate Orange]

  def self.total_quantity(wines)
    total_quantity = 0
    wines.each do |wine|
      total_quantity += wine.quantity
    end
    total_quantity
  end

  def self.total_value(wines)
    total_value = 0
    wines.each do |wine|
      total_value += wine.unit_price
    end
    total_value
  end

  $makers = [
    "Familia Torres",
    "Bodega Catena",
    "Vega Sicilia",
    "Henschke",
    "Concha y Toro",
    "Penfolds",
    "Domaine de la Romanée Conti",
    "CVNE",
    "Antinori",
    "Chateau Musar"
  ]

  $countries = ["France", "Lebanon", "Spain", "Australia", "Italy", "Argentina", "Chile"]
  $regions = ["Bordeaux", "Burgundy", "Piemonte", "Omina Romana", "Sicilia", "Bekaa Valley", "Mendoza"]
end
