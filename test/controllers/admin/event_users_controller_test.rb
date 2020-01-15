require 'test_helper'

class Admin::EventUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_event_users_destroy_url
    assert_response :success
  end

end
