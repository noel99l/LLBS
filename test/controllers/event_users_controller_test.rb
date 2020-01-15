require 'test_helper'

class EventUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get event_users_index_url
    assert_response :success
  end

end
