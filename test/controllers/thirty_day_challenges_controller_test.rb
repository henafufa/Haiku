require "test_helper"

class ThirtyDayChallengesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get thirty_day_challenges_index_url
    assert_response :success
  end
end
