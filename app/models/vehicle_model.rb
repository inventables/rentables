class VehicleModel < ApplicationRecord
  belongs_to :vehicle_category
  has_many :vehicles

  delegate :name, to: :vehicle_category, prefix: :category
  delegate :daily_price, to: :vehicle_category

  def make_and_name
    "#{make} #{name}"
  end
end
