require 'test_helper'

class ReservationFlowTest < ActionDispatch::IntegrationTest
  test "should create a reservation if a car is available to be rented" do
    vehicle_category = FactoryBot.create :vehicle_category
    vehicle_model = FactoryBot.create :vehicle_model, vehicle_category: vehicle_category
    FactoryBot.create :vehicle, vehicle_model: vehicle_model

    # create 2 reservations that allow for another reservation in between them
    FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: "2019-01-01", end_date: "2019-01-10"
    FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: "2019-01-21", end_date: "2019-01-30"

    # try to make a reservation in the empty space between existing reservations
    post reservations_path, params: { reservation: { start_date: "2019-01-11", end_date: "2019-01-20", vehicle_category_id: vehicle_category.id } }

    # the new reservation should be saved
    assert_equal 3, Reservation.count
  end

  test "cannot create a reservation when no vehicles are available" do
    vehicle_category = FactoryBot.create :vehicle_category
    vehicle_model = FactoryBot.create :vehicle_model, vehicle_category: vehicle_category
    FactoryBot.create :vehicle, vehicle_model: vehicle_model

    # create a reservation that lasts the entire month
    FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: "2019-01-01", end_date: "2019-01-31"

    # by having only one car we should not be able to make new reservations during that month
    post reservations_path, params: { reservation: { start_date: "2019-01-11", end_date: "2019-01-20", vehicle_category_id: vehicle_category.id } }

    # the new reservation should not be saved
    assert_equal 1, Reservation.count
  end

  test "cannot create a reservation when no vehicles are available during the entire time range" do
    vehicle_category = FactoryBot.create :vehicle_category
    vehicle_model = FactoryBot.create :vehicle_model, vehicle_category: vehicle_category
    FactoryBot.create :vehicle, vehicle_model: vehicle_model

    # create a short reservation in the middle of the month
    FactoryBot.create :reservation, vehicle_category: vehicle_category, start_date: "2019-01-15", end_date: "2019-01-16"

    # by having only one car we should not be able to make new reservations including those days
    post reservations_path, params: { reservation: { start_date: "2019-01-11", end_date: "2019-01-20", vehicle_category_id: vehicle_category.id } }

    # the new reservation should not be saved
    assert_equal 1, Reservation.count
  end
end
