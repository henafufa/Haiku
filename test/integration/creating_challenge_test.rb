require "test_helper"

class CreatingChallengeTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    @challenge = challenges(:one)
  end

  test "challenge creating for logged in user" do
    log_in_as(@user)
    get root_path

    verse_1 = "haiku is fine"
    verse_2 = "kaf talo salin aful"
    verse_3 = "haiku is fine"
    is_public = true
    tag = "funny"
    bgcolor = "#ededed"
    assert_difference 'Challenge.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2 } }
    end
    
    assert_redirected_to challenge_user_path
    follow_redirect!
  end
  test "send challenges for user" do
    log_in_as(@user)
    get root_path

    verse_1 = "haiku is fine"
    verse_2 = "kaf talo salin aful"
    assert_difference 'Challenge.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2 } }
    end
    assert_redirected_to challenge_user_path
    get search_user_path, params: { search: "archer" }
    get challenge_user_path
    assert_difference 'ChallengeUser.count', 1 do
      post search_user_path, params: { challenge_id: @challenge.id, user_id: @other.id }
    end
  end
  test "challenged user see the challenge" do
    log_in_as(@other)
    get challenge_user_path
    # assert template 
  end
end
