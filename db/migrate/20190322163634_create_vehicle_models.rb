class CreateVehicleModels < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_models do |t|
      t.string :make
      t.string :name
      t.references :vehicle_category, foreign_key: true

      t.timestamps
    end

    add_index :vehicle_models, [:make, :model], unique: true
  end
end
