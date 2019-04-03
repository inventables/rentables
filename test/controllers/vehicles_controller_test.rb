require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vehicles_path
    assert_response :success
  end

end
