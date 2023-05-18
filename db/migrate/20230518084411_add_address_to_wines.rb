class AddAddressToWines < ActiveRecord::Migration[7.0]
  def change
    add_column :wines, :address, :string
  end
end
