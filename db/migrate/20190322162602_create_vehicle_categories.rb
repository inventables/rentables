class CreateVehicleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_categories do |t|
      t.string :name
      t.decimal :daily_price, precision: 5, scale: 2

      t.timestamps
    end
    add_index :vehicle_categories, :name, unique: true
  end
end
