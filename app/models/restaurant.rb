class Restaurant < ApplicationRecord
  has_many :wines
  has_many :storage_locations
end
