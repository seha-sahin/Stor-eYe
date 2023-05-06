class PurchasingRequest < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  belongs_to :supplier
  validates :user, presence: true
  validates :supplier, presence: true
  has_many :purchasing_request_items, dependent: :destroy
  has_many :items, through: :purchasing_request_items
  has_many :wines, through: :purchasing_request_items

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
