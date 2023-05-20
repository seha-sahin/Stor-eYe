class AddCoordinatesToWines < ActiveRecord::Migration[7.0]
  def change
    add_column :wines, :latitude, :float
    add_column :wines, :longitude, :float
  end
end
