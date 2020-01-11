require 'test_helper'

class MusicsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get musics_new_url
    assert_response :success
  end

  test "should get show" do
    get musics_show_url
    assert_response :success
  end

  test "should get create" do
    get musics_create_url
    assert_response :success
  end

  test "should get edit" do
    get musics_edit_url
    assert_response :success
  end

  test "should get update" do
    get musics_update_url
    assert_response :success
  end

  test "should get destroy" do
    get musics_destroy_url
    assert_response :success
  end

end
