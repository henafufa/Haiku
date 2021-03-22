require "test_helper"

class ProfileLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @another_user = users(:archer)
  end
  test "profile_view_for_login_user" do
    log_in_as(@user)
    get root_path

    assert_template 'static_pages/home'

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    bgcolor = "red"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, bgcolor: bgcolor }, post_button:"Post" }
    end

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    bgcolor = "red"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, bgcolor: bgcolor }, post_button:"Post" }
    end

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    bgcolor = "red"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, bgcolor: bgcolor }, post_button:"Post" }
    end

    assert_redirected_to root_url
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", "#{root_url}/users/#{@user.id}/private_post"
    assert_select "button",  "Start Challenge"
    assert_select "button", "Activities"

    assert_select 'h3', text: "#{@user.name}'s Activity"
    activites = get_activities(@user).all
    activites.each do |activity|
      assert activity.owner == @user
    end
    # assert_select 'title', full_title(@user.name)
  end

  test "profile_view_for_another_user" do
    log_in_as(@user)
    get root_path

    assert_template 'static_pages/home'

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    bgcolor = "red"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, bgcolor: bgcolor }, post_button:"Post" }
    end

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    bgcolor = "red"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, bgcolor: bgcolor }, post_button:"Post" }
    end

    verse_1 = "cafe patio"
    verse_2 = "above the cacophony"
    verse_3 = "cafe patio"
    bgcolor = "red"

    assert_difference 'Haiku.count', 1 do
      post haikus_path, params: { haiku: { verse_1: verse_1, verse_2: verse_2, verse_3: verse_3, bgcolor: bgcolor }, post_button:"Post" }
    end

    assert_redirected_to root_url
    get user_path(@another_user)

    assert_template 'users/show'
    # assert_select "a[href=?]", "#{root_url}/users/#{@user.id}/private_post", count:0


    assert_select 'h3', text: "#{@another_user.name}'s Post"
    assert_select "a[href=?]", user_path(@another_user)

    @another_user.haikus.each do |haiku|
      assert_match haiku.verse_1, response.body
      assert_match haiku.verse_2, response.body
      assert_match haiku.verse_3, response.body
      assert_select "div#haiku-collapse-#{haiku.id}"
      assert_select "a[href=?]", haiku_path(haiku)
    end
  end

  # test "profile_view_for_another_user_has_no_Activites_and_start_challenge_buttons" do
  #   log_in_as(@user)
  #   get root_path

  #   assert_template 'static_pages/home'
  #   get user_path(@another_user)
    
  #   assert_template 'users/show'
  #   @user.reload
  #   assert_select 'h3', text: "#{@another_user.name}'s Post"

  #   assert_select "button",  text:"Start Challenge", count: 0
  #   assert_select "button", text:"Activities", count: 0
  #   assert_select "button",  text:"Track Challenge", count: 0


  # end
  
  # test "Private_post_link_should_not_be_present_for_another_user" do
  #   log_in_as(@user)
  #   get root_path

  #   assert_template 'static_pages/home'
  #   get user_path(@another_user)
    
  #   assert_template 'users/show'
  #   @user.reload
  #   assert_select 'h3', text: "#{@another_user.name}'s Post"

  #   assert_select "a[href=?]", "#{root_url}/users/#{@user.id}/private_post", count:0
  #   assert_select "a[href=?]", "#{root_url}/users/#{@another_user.id}/private_post", count:0



  # end

  


end
