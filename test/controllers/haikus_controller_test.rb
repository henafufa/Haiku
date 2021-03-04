require "test_helper"

class HaikusControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @haiku = haikus(:defualt_haiku)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Haiku.count' do
      post haikus_path, params: { haiku: { verse_1: "Lorem ipsum", verse_2: "Lorem ipsum", verse_2: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Haiku.count' do
      delete haiku_path(@haiku)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    haiku = haikus(:archer_haiku)
    assert_no_difference 'Haiku.count' do
      delete haiku_path(haiku)
    end
    assert_redirected_to root_url
  end

  


end
