class CreateStorageLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :storage_locations do |t|
      t.string :name
      t.string :address
      t.integer :capacity
      t.string :temperature
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
