require 'test_helper'

class LyricsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get lyrics_create_url
    assert_response :success
  end

  test "should get edit" do
    get lyrics_edit_url
    assert_response :success
  end

  test "should get update" do
    get lyrics_update_url
    assert_response :success
  end

  test "should get destroy" do
    get lyrics_destroy_url
    assert_response :success
  end

end
