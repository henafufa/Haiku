require "test_helper"

class HaikuCommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @haiku = haikus(:defualt_haiku)
    @haiku_comment = haiku_comments(:comment_default)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Haiku.count', 0 do
      post haiku_comments_path, params: { haiku_comment: { verse_1: "Lorem ipsum", verse_2: "Lorem ipsum", verse_3: "Lorem ipsum", haiku_id: @haiku.id } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'HaikuComment.count', 0 do
      delete haiku_comment_path(@haiku_comment)
    end
    assert_redirected_to login_url
  end

  test "should  destroy haiku for correct user" do
    log_in_as(users(:michael))
    haiku = haikus(:defualt_haiku)
    assert_difference 'Haiku.count', -1 do
      delete haiku_path(haiku)
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy for wrong haiku" do
    log_in_as(users(:michael))
    haiku_comment = haiku_comments(:archer_comment)
    assert_no_difference 'HaikuComment.count', 0 do
      delete haiku_path(haiku_comment)
    end
    assert_redirected_to root_url
  end
end
