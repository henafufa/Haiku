require "test_helper"

class ReactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @reaction = Reaction.new(reactor_id: users(:michael).id, micropost_id: microposts(:orange).id)
  end
  test "should be valid" do
    assert @reaction.valid?
  end
  test "should require a reactor_id" do
    @reaction.reactor_id = nil
    assert_not @reaction.valid?
  end
  test "should require a micropost_id" do
    @reaction.micropost_id = nil
    assert_not @reaction.valid?
  end
  
end
