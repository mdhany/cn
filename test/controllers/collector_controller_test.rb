require 'test_helper'

class CollectorControllerTest < ActionController::TestCase
  test "should get event" do
    get :event
    assert_response :success
  end

end
