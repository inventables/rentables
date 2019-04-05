class VehiclesController < ApplicationController
  before_action :load_vehicle_models, only: [:new, :create]

  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new vehicle_params

    if @vehicle.save
      redirect_to vehicles_path
    else
      render action: "new"
    end
  end

  private
  def load_vehicle_models
    @vehicle_models = VehicleModel.all
  end

  def vehicle_params
    params.require(:vehicle).permit(:year, :vehicle_model_id, :commissioned_on, :decommissioned_on)
  end
end
