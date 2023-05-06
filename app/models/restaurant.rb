class Restaurant < ApplicationRecord
  has_many :wines, dependent: :destroy
  has_many :storage_locations, dependent: :destroy
end
