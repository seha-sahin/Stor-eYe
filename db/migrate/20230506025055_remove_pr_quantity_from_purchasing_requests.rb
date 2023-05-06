class RemovePrQuantityFromPurchasingRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :purchasing_requests, :pr_quantity
  end
end
