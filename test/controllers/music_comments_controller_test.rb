require 'test_helper'

class MusicCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get music_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get music_comments_destroy_url
    assert_response :success
  end

end
