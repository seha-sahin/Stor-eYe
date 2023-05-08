class PurchasingRequest < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  belongs_to :supplier
  validates :user, presence: true
  validates :supplier, presence: true
  has_many :purchasing_request_items, dependent: :destroy
  has_many :items, through: :purchasing_request_items
  has_many :wines, through: :purchasing_request_items
  accepts_nested_attributes_for :purchasing_request_items

  TIME_SLOTS = [
    ['8:00 AM - 10:00 AM', '8:00-10:00'],
    ['10:00 AM - 12:00 PM', '10:00-12:00'],
    ['12:00 PM - 2:00 PM', '12:00-14:00'],
    ['2:00 PM - 4:00 PM', '14:00-16:00'],
    ['4:00 PM - 6:00 PM', '16:00-18:00']
  ].freeze

  def total_quantity
    purchasing_request_items.sum(:quantity)
  end

  pg_search_scope :search_by_pr_number,
    against: :pr_number,
    using: { tsearch: { prefix: true } }

  pg_search_scope :search_by_pr_quantity,
    against: { pr_quantity: 'A' },
    using: { tsearch: { prefix: true } },
    associated_against: {
      supplier: { name: 'A' },
      user: { email: 'A' }
    }

end
