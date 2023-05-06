class PurchasingRequestItem < ApplicationRecord
  belongs_to :purchasing_request
  belongs_to :wine
end
