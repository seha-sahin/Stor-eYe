class CreatePurchasingRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :purchasing_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.jsonb :pr_quantity
      t.date :delivery_date
      t.string :delivery_time_slot

      t.timestamps
    end
  end
end
