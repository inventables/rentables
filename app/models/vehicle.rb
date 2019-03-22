class Vehicle < ApplicationRecord
  belongs_to :vehicle_model
  delegate :make, :vehicle_category, :category_name, :daily_price, to: :vehicle_model
  delegate :name, to: :vehicle_model, prefix: :model
end
