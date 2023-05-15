class AddNoteToPurchasingRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :purchasing_requests, :note, :text
  end
end
