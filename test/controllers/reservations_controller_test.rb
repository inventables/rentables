require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reservations_path
    assert_response :success
  end

  test "should get new reservation page" do
    get new_reservation_path
    assert_response :success
  end

  test "should not create new reservation with missing vehicle category id" do
    post reservations_path, params: { reservation: { start_date: "2019-01-01", end_date:  "2019-01-07" } }
    assert_response :success
    assert_equal 0, Reservation.all.count
  end

  test "should not create new reservation with end date before start date" do
    FactoryBot.create :vehicle # this also creates the VehicleModel and VehicleCategory
    vehicle_category = VehicleCategory.first

    post reservations_path, params: { reservation: { start_date: "2019-01-01", end_date: "2018-12-01", vehicle_category_id: vehicle_category.id } }
    assert_response :success
    assert_equal 0, Reservation.all.count
  end

  test "should create new reservation with correct data" do
    FactoryBot.create :vehicle # this also creates the VehicleModel and VehicleCategory
    vehicle_category = VehicleCategory.first

    post reservations_path, params: { reservation: { start_date: "2019-01-01", end_date: "2019-01-07", vehicle_category_id: vehicle_category.id } }
    follow_redirect!
    assert_response :success
    assert_equal 1, Reservation.all.count
  end
end
