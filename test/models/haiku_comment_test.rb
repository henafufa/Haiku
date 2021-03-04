require "test_helper"

class HaikuCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    verse_1 = "First Lorem"
    verse_2 = "Second Lorem"
    verse_3 = "Third Lorem"
    @haiku_comment = HaikuComment.new(user_id: users(:michael).id, haiku_id: haikus(:public).id, verse_1: verse_1, verse_2: verse_2, verse_3:verse_3 )
  end
  test "should be valid" do
    assert @haiku_comment.valid?
  end
  # test "should require a user_id" do
  #   @comment.user_id = nil
  #   assert_not @comment.valid?
  # end
  # test "should require a micropost_id" do
  #   @comment.micropost_id = nil
  #   assert_not @comment.valid?
  # end
  # test "should require a content" do
  #   @comment.content = nil
  #   assert_not @comment.valid?
  # end
  # test "comment should not be greater than 120 character" do
  #   @comment.content = "c" * 121
  #   assert_not @comment.valid?
  # end
  # test "order should be most recent first" do
  #   assert_equal comments(:most_recent), Comment.first
  # end
end
