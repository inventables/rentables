class Reservation < ApplicationRecord
  belongs_to :vehicle_category
  delegate :name, to: :vehicle_category, prefix: :category

  after_create :set_total_price

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :vehicle_category, presence: true
  validate :end_date_has_to_be_after_start_date

  private
  def set_total_price
    update_attribute :total_price, vehicle_category.daily_price * (end_date - start_date).to_i
  end

  def end_date_has_to_be_after_start_date
    if end_date <= start_date
      errors.add(:end_date, "can't be before or on start date")
    end
  end
end
