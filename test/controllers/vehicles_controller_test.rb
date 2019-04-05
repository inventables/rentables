require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vehicles_path
    assert_response :success
  end

  test "should get new vehicle page" do
    get new_vehicle_path
    assert_response :success
  end

  test "should not create new vehicle with missing vehicle model" do
    post vehicles_path, params: { vehicle: { year: "2019", commissioned_on: "2019-01-01" } }
    assert_response :success
    assert_equal 0, Vehicle.all.count
  end

  test "should not create new vehicle with missing commissioned date" do
    vehicle_model = FactoryBot.create :vehicle_model

    post vehicles_path, params: { vehicle: { year: "2019", vehicle_model_id: vehicle_model.id } }
    assert_response :success
    assert_equal 0, Vehicle.all.count
  end

  test "should create new vehicle with all properties present" do
    vehicle_model = FactoryBot.create :vehicle_model

    post vehicles_path, params: { vehicle: { year: "2019", commissioned_on: "2019-01-01", vehicle_model_id: vehicle_model.id } }
    follow_redirect!
    assert_response :success
    assert_equal 1, Vehicle.all.count
  end
end
