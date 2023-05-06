class PurchasingRequest < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  belongs_to :supplier
  validates :user, presence: true
  validates :supplier, presence: true
  validates :pr_quantity, presence: true
  attribute :pr_quantity, :jsonb


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
