require "test_helper"

class SearchTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    @haiku = haikus(:archer_haiku)
  end
  test "search haiku for logged in user" do
    log_in_as(@user)
    get root_path

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    tag = "funny"
    is_public = true
    bgcolor = "#dfdfdf"

    image = fixture_file_upload('test/fixtures/kitten.jpg','image/jpeg')
    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, tag: tag, public: is_public, bgcolor: bgcolor }, post_button: "Post"  }
    end
    
    assert_redirected_to root_url
    follow_redirect!
    get search_path, params: { search: "patio", filter: "Haiku" }
    get root_url
  end
  test "search users for logged in user" do
    log_in_as(@user)
    get root_path
    get search_path, params: { search: "arch", filter: "Users" }
    get users_path
  end
end
