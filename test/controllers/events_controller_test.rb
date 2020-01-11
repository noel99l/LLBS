require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get events_show_url
    assert_response :success
  end

  test "should get index" do
    get events_index_url
    assert_response :success
  end

  test "should get confirm" do
    get events_confirm_url
    assert_response :success
  end

end
