require "test_helper"

class ChallengeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @challenge = Challenge.new(user_id: users(:michael).id, verse_1: "verse_1", verse_2: "verse_2")
  end
  test "should be valid" do
    assert @challenge.valid?
  end
  test "should require a user_id" do
    @challenge.user_id = nil
    assert_not @challenge.valid?
  end
  test "should require a verse_1" do
    @challenge.verse_1 = nil
    assert_not @challenge.valid?
  end
  test "should not require a verse_2" do
    @challenge.verse_2 = nil
    assert @challenge.valid?
  end
  test "verse_1 should be at most 40 characters" do
    @challenge.verse_1 = "a" * 41
    assert_not @challenge.valid?
  end
  test "verse_2 should be at most 40 characters" do
    @challenge.verse_2 = "a" * 41
    assert_not @challenge.valid?
  end
end
