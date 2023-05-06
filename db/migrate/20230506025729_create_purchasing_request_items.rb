class CreatePurchasingRequestItems < ActiveRecord::Migration[7.0]
  def change
    create_table :purchasing_request_items do |t|
      t.references :purchasing_request, null: false, foreign_key: true
      t.references :wine, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
