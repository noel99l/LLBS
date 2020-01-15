require 'test_helper'

class Admin::EntryTablesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_entry_tables_destroy_url
    assert_response :success
  end

end
