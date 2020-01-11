require 'test_helper'

class AfterPartiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get after_parties_show_url
    assert_response :success
  end

end
