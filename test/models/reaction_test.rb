require "test_helper"

class ReactionTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @reaction = @user.reactions.build(micropost_id: microposts(:orange).id)
  end
  test "should be valid" do
    assert @reaction.valid?
  end
  test "should require a user_id" do
    @reaction.user_id = nil
    assert_not @reaction.valid?
  end
  test "should require a micropost_id" do
    @reaction.micropost_id = nil
    assert_not @reaction.valid?
  end
  
end
