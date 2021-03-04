require "test_helper"

class HaikuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @haiku = @user.haikus.build(verse_1: "Lorem ipsum", verse_2: "Lorem ipsum", verse_3: "Lorem ipsum", user_id: @user.id)
    # This code is not idiomatically correct.
    # @haiku = Haiku.new(verse_1: "Lorem ipsum", verse_2: "Lorem ipsum", verse_3: "Lorem ipsum", user_id: @user.id)
  end
  test "should be valid" do
    assert @haiku.valid?
  end
  test "user id should be present" do
    @haiku.user_id = nil
    assert_not @haiku.valid?
  end
  test "verse_1 should be present" do
    @haiku.verse_1 = " "
    assert_not @haiku.valid?
  end
  test "verse_2 should be present" do
    @haiku.verse_2 = " "
    assert_not @haiku.valid?
  end
  
  test "verse_3 should be present" do
    @haiku.verse_3 = " "
    assert_not @haiku.valid?
  end
  
  test "verse_1 should be at most 40 characters" do
    @haiku.verse_1 = "a" * 41
    assert_not @haiku.valid?
  end

  test "verse_2 should be at most 40 characters" do
    @haiku.verse_2 = "a" * 41
    assert_not @haiku.valid?
  end

  test "verse_3 should be at most 40 characters" do
    @haiku.verse_3 = "a" * 41
    assert_not @haiku.valid?
  end

  test "order should be most recent first" do
    assert_equal haikus(:most_recent), Haiku.first
  end

  test "defualt haiku should be public" do
    # @haiku.public = false
    p "public @haiku.public? #{@haiku.public?}"
    assert @haiku.public?
  end

  test "private haiku's public should be false" do
    @haiku.public = false
    p "public @haiku.public? #{@haiku.public?}"
    assert_not @haiku.public?
  end
  

  test "associated comment should be destroyed" do
    @haiku.save
    @haiku.haiku_comments.create!(verse_1: "Lorem ipsum", verse_2: "Lorem ipsum", verse_3: "Lorem ipsum", user_id: users(:michael).id)
    assert_difference 'HaikuComment.count', -1 do
      @haiku.destroy
    end
  end
end
