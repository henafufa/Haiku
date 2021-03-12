require "test_helper"

class ChallengeUsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @challenge_user = challenge_users(:one)
    @challenge = challenges(:one)
    @user = users(:michael)
  end
  test "should redirect create when not logged in" do
    assert_no_difference 'ChallengeUser.count' do
      post search_user_path, params: { user_id: @user.id, challenge_id: @challenge.id }
    end
    assert_redirected_to login_url
  end
  test "should redirect destroy when not logged in" do
    assert_no_difference 'ChallengeUser.count' do
      delete search_user_path, params: { user_id: @user.id, challenge_id: @challenge.id }
    end
    assert_redirected_to login_url
  end
end
