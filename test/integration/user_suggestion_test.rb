require "test_helper"

class UserSuggestionTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  test "test the interface of the suggestion page fragment" do
    log_in_as(@user)
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'div.suggestions-header', "Suggested"
  end
end
