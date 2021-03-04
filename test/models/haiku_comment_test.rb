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

  test "should require a user_id" do
    @haiku_comment.user_id = nil
    assert_not @haiku_comment.valid?
  end

  test "should require a micropost_id" do
    @haiku_comment.haiku_id = nil
    assert_not @haiku_comment.valid?
  end

  test "verse_1 should be present" do
    @haiku_comment.verse_1 = " "
    assert_not @haiku_comment.valid?
  end
  test "verse_2 should be present" do
    @haiku_comment.verse_2 = " "
    assert_not @haiku_comment.valid?
  end
  
  test "verse_3 should be present" do
    @haiku_comment.verse_3 = " "
    assert_not @haiku_comment.valid?
  end
  
  test "verse_1 should be at most 40 characters" do
    @haiku_comment.verse_1 = "a" * 41
    assert_not @haiku_comment.valid?
  end

  test "verse_2 should be at most 40 characters" do
    @haiku_comment.verse_2 = "a" * 41
    assert_not @haiku_comment.valid?
  end

  test "verse_3 should be at most 40 characters" do
    @haiku_comment.verse_3 = "a" * 41
    assert_not @haiku_comment.valid?
  end
 
  test "order should be most recent first" do
    assert_equal haiku_comments(:most_recent), HaikuComment.first
  end
  
end
