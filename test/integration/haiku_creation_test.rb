require "test_helper"

class HaikuCreationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end

  test "haiku creation valid submission" do
    log_in_as(@user)
    get root_path

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    tag = "funny"
    is_public = true
    bgcolor = "#dfdfdf"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3}, post_button: "Post" }
    end

    assert_redirected_to root_url
    follow_redirect!
  end

  test "haiku creation with bg-image valid submission" do
    log_in_as(@user)
    get root_path
    is_public = true

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    
    image = fixture_file_upload('test/fixtures/kitten.jpg','image/jpeg')
    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, public: is_public, image: image }, post_button: "Post"  }
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_select 'div.haiku-image-card'
  end

  test "haiku creation with bg-color valid submission" do
    log_in_as(@user)
    get root_path

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    bgcolor = "red"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, bgcolor: bgcolor }, post_button:"Post" }
    end

    assert_redirected_to root_url
    follow_redirect!
  end

  test "haiku creation invaid submission" do
    log_in_as(@user)
    get root_path
    verse_1 = " "
    verse_2 = " "
    verse_3 = "My third verse"
    assert_difference 'Haiku.count', 0 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3 }, post_button:"Post" }
    end
    # assert FILL_IN.image.attached?
    assert flash.empty?
    assert_template 'static_pages/home'
    assert_select 'div#error_explanation'

  end

  test "haiku creation invaid submission for invalid syllabes count" do
    log_in_as(@user)
    get root_path
    verse_1 = "cafe patio cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe"
    assert_difference 'Haiku.count', 0 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3 }, post_button:"Post" }
    end
    # assert FILL_IN.image.attached?
    assert flash.empty?
    assert_template 'static_pages/home'
    assert_select 'div#error_explanation'
  end
  # test "verse_1 syllables should be 5(+, -)1" do
  #   @haiku.verse_1 = "yes yes yes yes yes yes"
  #   assert_not @haiku.valid?
  # end

end