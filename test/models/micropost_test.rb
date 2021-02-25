require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
    # This code is not idiomatically correct.
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
  end
  test "should be valid" do
    assert @micropost.valid?
  end
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  test "content should be present" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end
  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
  test "associated comment should be destroyed" do
    @micropost.save
    @micropost.comments.create!(content: "Lorem ipsum", user_id: users(:michael).id)
    assert_difference 'Comment.count', -1 do
      @micropost.destroy
    end
  end
end
