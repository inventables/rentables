class VehicleCategory < ApplicationRecord
  has_many :vehicle_models
  has_many :vehicles, through: :vehicle_models

  has_many :reservations
end
