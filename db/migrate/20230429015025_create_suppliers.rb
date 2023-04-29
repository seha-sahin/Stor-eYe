class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :contact_full_name
      t.string :contact_phone_number
      t.string :contact_email
      t.text :comment

      t.timestamps
    end
  end
end
