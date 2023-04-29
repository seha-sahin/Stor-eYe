class PurchasingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  validates :user, presence: true
  validates :supplier, presence: true
  validates :pr_quantity, presence: true
end
