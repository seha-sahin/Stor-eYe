class AddApprovalStatusToPurchasingRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :purchasing_requests, :approval_status, :string, default: 'pending'
  end
end
