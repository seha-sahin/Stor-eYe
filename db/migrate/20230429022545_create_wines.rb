class CreateWines < ActiveRecord::Migration[7.0]
  def change
    create_table :wines do |t|
      t.string :maker
      t.string :country
      t.integer :vintage
      t.string :colour
      t.string :region
      t.string :appellation
      t.string :volume
      t.string :cuvee
      t.string :tasting_notes
      t.string :grape_variety
      t.text :description
      t.references :supplier, null: false, foreign_key: true
      t.float :unit_price
      t.float :avg_price
      t.float :selling_price
      t.integer :quantity
      t.float :cost
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
