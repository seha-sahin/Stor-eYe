class Wine < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :wine_search,
                  against: %i[maker
                              country
                              vintage
                              colour
                              region
                              appellation
                              volume
                              cuvee
                              tasting_notes
                              grape_variety
                              description],
                  using: { tsearch: { prefix: true } }

  has_many :storage_locations, through: :restaurant
  has_many :purchasing_request_items
  belongs_to :supplier
  belongs_to :restaurant
  validates :maker, :country, :vintage, :colour, :region, :appellation, :volume, :cuvee, presence: true
  has_one_attached :photo
  geocoded_by :appellation
  after_validation :geocode, if: :will_save_change_to_appellation?

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
end
