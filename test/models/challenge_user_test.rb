require "test_helper"

class ChallengeUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @challenge_user = ChallengeUser.new(user_id: users(:michael).id, challenge_id: challenges(:one).id )
  end
  test "should be valid" do
    assert @challenge_user.valid?
  end
  test "should require a user_id" do
    @challenge_user.user_id = nil
    assert_not @challenge_user.valid?
  end
  test "should require a challenge_id" do
    @challenge_user.challenge_id = nil
    assert_not @challenge_user.valid?
  end
end
