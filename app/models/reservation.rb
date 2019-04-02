class Reservation < ApplicationRecord
  belongs_to :vehicle_category
  delegate :name, to: :vehicle_category, prefix: :category

  after_create :set_total_price

  private
  def set_total_price
    update_attribute :total_price, vehicle_category.daily_price * (end_date - start_date).to_i
  end
end
