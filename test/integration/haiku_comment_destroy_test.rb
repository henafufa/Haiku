require "test_helper"

class HaikuCommentDestroyTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # def setup
  #   @user = users(:michael)
  #   @haiku = haikus(:archer_haiku)
  # end

  # test "haiku delete" do
  #   log_in_as(@user)
  #   get root_path
  #   assert_select 'div.pagination'
  #   assert_select 'a', text: 'delete'
  #   haiku = @user.haiku.paginate(page: 1).first
  #   assert_difference 'HaikuComment.count', -1 do
  #     delete haiku_path(haiku)
  #   end
  # end

  # test " should redirect for wrong user on haiku delete" do
  #   log_in_as(@another_user)
  #   get root_path
  #   haiku = haikus(:defualt_haiku)
  #   assert_difference 'Haiku.count', 0 do
  #     delete haiku_path(haiku)
  #   end
  #   assert_redirected_to root_url
  #   follow_redirect!
  # end
end
