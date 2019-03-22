class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.integer :year
      t.references :vehicle_model, foreign_key: true
      t.date :commissioned_on
      t.date :decommissioned_on

      t.timestamps
    end
  end
end
