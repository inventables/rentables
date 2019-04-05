class Vehicle < ApplicationRecord
  belongs_to :vehicle_model
  delegate :make, :name, :vehicle_category, :category_name, :daily_price, to: :vehicle_model

  validates :commissioned_on, presence: true
end
