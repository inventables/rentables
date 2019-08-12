class Reservation < ApplicationRecord
  belongs_to :vehicle_category
  delegate :name, to: :vehicle_category, prefix: :category

  after_create :set_total_price

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :vehicle_category, presence: true
  validate :end_date_has_to_be_after_start_date
  validate :vehicle_available




  private

  def set_total_price
    update_attribute :total_price, vehicle_category.daily_price * (end_date - start_date).to_i
  end

  def end_date_has_to_be_after_start_date
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "can't be before or on start date")
    end
  end

  def vehicle_available
    return unless vehicle_category && errors.blank?

    errors.add(:base, "#{category_name} not available to reserve #{start_date} to #{end_date}.") if conflicting_reservations.count >= vehicle_category.vehicles.count
  end

  def conflicting_reservations
    category_reservations = self.vehicle_category.reservations

    category_reservations.where(conflict_case_1).or(
      category_reservations.where(conflict_case_2).or(
        category_reservations.where(conflict_case_3).or(
          category_reservations.where(conflict_case_4)
        )
      )
    )
  end

  def conflict_case_1
    <<~EOS
      start_date <= '#{start_date}'
      AND end_date >= '#{start_date}'
    EOS
  end

  def conflict_case_2
    <<~EOS
      start_date <= '#{end_date}'
      AND end_date >= '#{end_date}'
    EOS
  end

  def conflict_case_3
    <<~EOS
      start_date <= '#{start_date}'
      AND end_date >= '#{end_date}'
    EOS
  end

  def conflict_case_4
    <<~EOS
      start_date > '#{start_date}'
      AND end_date < '#{end_date}'
    EOS
  end
end
