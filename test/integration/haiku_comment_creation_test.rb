require "test_helper"

class HaikuCommentCreationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @haiku = haikus(:archer_haiku)
  end

  test "haiku comment creation valid submission" do
    log_in_as(@user)
    get root_path

    verse_1 = "My first comment verse"
    verse_2 = "My second comment verse"
    verse_3 = "My third comment verse"

    assert_difference 'HaikuComment.count', 1 do
      post haiku_comments_path, params: { haiku_comment: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3 }, haiku_id: @haiku.id }
    end
    assert_redirected_to root_url
    follow_redirect!
  end

  test "haiku comment creation invaid submission" do
    log_in_as(@user)
    get root_path

    verse_1 = " "
    verse_2 = " "
    verse_3 = "My third verse"

    assert_difference 'HaikuComment.count', 0 do
      post haiku_comments_path, params: { haiku_comment: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3 }, haiku_id: @haiku.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
  end
end
