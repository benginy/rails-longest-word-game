require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get games" do
    get pages_games_url
    assert_response :success
  end
end
