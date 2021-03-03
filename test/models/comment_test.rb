require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @comment = Comment.new(user_id: users(:michael).id, micropost_id: microposts(:orange).id, content: "the comment")
  end
  test "should be valid" do
    assert @comment.valid?
  end
  test "should require a user_id" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
  test "should require a micropost_id" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end
  test "should require a content" do
    @comment.content = nil
    assert_not @comment.valid?
  end
  test "comment should not be greater than 120 character" do
    @comment.content = "c" * 121
    assert_not @comment.valid?
  end
  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
end
