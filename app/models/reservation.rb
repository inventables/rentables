class Reservation < ApplicationRecord
  belongs_to :vehicle_category
  delegate :name, to: :vehicle_category, prefix: :category

  after_create :set_total_price

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :vehicle_category, presence: true
  validate :end_date_has_to_be_after_start_date
  validate :no_conflicting_reservations

  private
  def set_total_price
    update_attribute :total_price, vehicle_category.daily_price * (end_date - start_date).to_i
  end

  def end_date_has_to_be_after_start_date
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "can't be before or on start date")
    end
  end

  def no_conflicting_reservations
    errors.add(:base, "Reservation cannot overlap with an existing reservation") if conflicting_reservations.present?
  end

  def conflicting_reservations
    Reservation.where(overlap_case_1).or(
      Reservation.where(overlap_case_2).or(
        Reservation.where(overlap_case_3).or(
          Reservation.where(overlap_case_4)
        )
      )
    )
  end

  def overlap_case_1
    <<~EOS
      start_date <= '#{start_date}'
      AND end_date >= '#{start_date}'
    EOS
  end

  def overlap_case_2
    <<~EOS
      start_date <= '#{end_date}'
      AND end_date >= '#{end_date}'
    EOS
  end

  def overlap_case_3
    <<~EOS
      start_date <= '#{start_date}'
      AND end_date >= '#{end_date}'
    EOS
  end

  def overlap_case_4
    <<~EOS
      start_date >= '#{start_date}'
      AND end_date <= '#{end_date}'
    EOS
  end
end
