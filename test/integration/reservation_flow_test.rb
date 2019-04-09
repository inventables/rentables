require 'test_helper'

class ReservationFlowTest < ActionDispatch::IntegrationTest
  test "should create a reservation if a car is available to be rented" do
    FactoryBot.create :vehicle # this also creates the VehicleModel and VehicleCategory
    vehicle_category = VehicleCategory.first

    # lets create 2 reservations that allow for another reservation in between them
    FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: "2019-01-01", end_date: "2019-01-10"
    FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: "2019-01-21", end_date: "2019-01-30"

    # we should be able to make a reservation in the empty space between existing reservations
    post reservations_path, params: { reservation: { start_date: "2019-01-11", end_date: "2019-01-20", vehicle_category_id: vehicle_category.id } }
    follow_redirect!
    assert_response :success
    assert_equal 3, Reservation.count
  end

  test "cannot create a reservation when no vehicles are available" do
    FactoryBot.create :vehicle # this also creates the VehicleModel and VehicleCategory
    vehicle_category = VehicleCategory.first

    # lets create a reservation that lasts the entire month
    FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: "2019-01-01", end_date: "2019-01-31"

    # by having only one car we should not be able to make new reservations
    post reservations_path, params: { reservation: { start_date: "2019-01-11", end_date: "2019-01-20", vehicle_category_id: vehicle_category.id } }
    follow_redirect!
    assert_response :success
    assert_equal 1, Reservation.count
  end

  test "creating new reservations with a lot of existing data should complete in reasonable time" do
    CATEGORY_COUNT = 5
    MODEL_COUNT = 5
    VEHICLE_COUNT = 10
    NUMBER_OF_WEEKS_RENTED = 4
    EXPECTED_RESERVATION_COUNT = CATEGORY_COUNT * MODEL_COUNT * VEHICLE_COUNT * NUMBER_OF_WEEKS_RENTED

      CATEGORY_COUNT.times { FactoryBot.create :vehicle_category }

    VehicleCategory.all.each do |vehicle_category|
      MODEL_COUNT.times { FactoryBot.create :vehicle_model, vehicle_category: vehicle_category }
    end

    VehicleModel.all.each do |vehicle_model|
      VEHICLE_COUNT.times { FactoryBot.create :vehicle, vehicle_model: vehicle_model }
    end

    start_date = Date.parse("2019-01-01")

    # each category has MODEL_COUNT models, and each model has VEHICLE_COUNT vehicles available, therefore we can rent MODEL_COUNT * VEHICLE_COUNT cars of each category
    vehicle_categories = VehicleCategory.all

    # we generate a category spanning from a week each for the first 4 weeks of the 2019 for each vehicle
    (MODEL_COUNT * VEHICLE_COUNT).times do
      vehicle_categories.each do |vehicle_category|
        (1..NUMBER_OF_WEEKS_RENTED).each do |i|
          reservation_start_date = start_date + (7 * (i - 1).days)
          FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: reservation_start_date, end_date: reservation_start_date + 6
        end
      end
    end

    # we should not be able to generate a reservation for January as all the vehicles are booked
    post reservations_path, params: { reservation: { start_date: "2019-01-11", end_date: "2019-01-20", vehicle_category_id: VehicleCategory.first.id } }
    follow_redirect!
    assert_response :success
    assert_equal EXPECTED_RESERVATION_COUNT, Reservation.count
  end
end
