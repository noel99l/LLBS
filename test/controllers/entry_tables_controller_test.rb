require 'test_helper'

class EntryTablesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get entry_tables_create_url
    assert_response :success
  end

  test "should get destroy" do
    get entry_tables_destroy_url
    assert_response :success
  end

end
