class ReservationsController < ApplicationController
  before_action :load_vehicle_categories, only: [:new, :create]

  def index
    @reservations = Reservation.all.order("start_date ASC")
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new reservation_params

    if @reservation.save
      redirect_to reservations_path
    else
      render action: "new"
    end
  end

  private
  def load_vehicle_categories
    @vehicle_categories = VehicleCategory.all
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :vehicle_category_id)
  end
end
