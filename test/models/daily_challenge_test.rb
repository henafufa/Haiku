require "test_helper"

class DailyChallengeTest < ActiveSupport::TestCase
  # setup for creating new challenge
  def setup
    @dayChallenge = DailyChallenge.new(user_id: users(:michael).id, postStatus: true, thirtyDates: Time.zone.now)
  end

  # check created challenge vaid
  test "should be valid" do
    assert @dayChallenge.valid?
  end

  # check that user_id required
   test "should require a user_id" do
    @dayChallenge.user_id = nil
    assert_not @dayChallenge.valid?
  end

  # check that haiku_id required
  # test "should require a haiku_id" do
  #   @dayChallenge.haiku_id = nil
  #   assert_not @dayChallenge.valid?
  # end

   # check that postStatus required
  # test "should require a post status" do
  #   @dayChallenge.postStatus = nil
  #   assert_not @dayChallenge.valid?
  # end

  # check that thirtyDates required
  test "should require a thirtyDates" do
    @dayChallenge.thirtyDates = nil
    assert_not @dayChallenge.valid?
  end

end
