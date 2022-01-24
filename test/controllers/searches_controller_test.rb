require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get seach" do
    get searches_seach_url
    assert_response :success
  end
end
