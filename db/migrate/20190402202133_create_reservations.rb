class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :total_price, precision: 5, scale: 2
      t.references :vehicle_category, foreign_key: true

      t.timestamps
    end
  end
end
