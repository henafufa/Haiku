require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    
    #mekedems code starts here#
    @michael_with_tag = users(:michael)
    @archer_with_tag = users(:archer)
    @lana_with_tag = users(:lana)
    
    @michael_with_tag.haikus.build(verse_1: "cafe patio", verse_2: "above the cacophony", verse_3: "cafe patio", user_id: @michael_with_tag.id, tag:"funny")
    @archer_with_tag.haikus.build(verse_1: "cafe patio", verse_2: "above the cacophony", verse_3: "cafe patio", user_id: @archer_with_tag.id, tag:"funny")
    @lana_with_tag.haikus.build(verse_1: "cafe patio", verse_2: "above the cacophony", verse_3: "cafe patio", user_id: @lana_with_tag.id, tag:"sad")
    #mekedems code ends here
  end
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_USER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6 
    assert_not @user.valid?
  end
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5 
    assert_not @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
    # assert_not @user.authenticated?('')
    assert_not @user.authenticated?(:remember, '')
  end
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "associated haikus should be destroyed" do
    @user.save
    @user.haikus.create!(verse_1: "cafe patio", verse_2: "above the cacophony", verse_3: "cafe patio", user_id: @user.id)
    assert_difference 'Haiku.count', -1 do
      @user.destroy
    end
  end

  test "associated comment should be destroyed" do
    @user.save
    @user.comments.create!(content: "Lorem ipsum", micropost_id: microposts(:orange).id)
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end

  test "associated haiku-comment should be destroyed" do
    
    @user.save
    @user.haiku_comments.create!(verse_1: "cafe patio", verse_2: "above the cacophony", verse_3: "cafe patio", haiku_id: haikus(:defualt_haiku).id )
    assert_difference 'HaikuComment.count', -1 do
      @user.destroy
    end
  end
  test "associated challenge should be destroyed" do
    @user.save
    @user.challenges.create!(verse_1: "cafe patio", verse_2: "above the cacophony")
    assert_difference 'Challenge.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
  # test "should react and unreact a micropost" do
  #   michael = users(:michael)
  #   orange = microposts(:orange)
  #   assert_not michael.react?(orange)
  #   michael.react(orange)
  #   assert michael.react?(orange)
  #   # assert archer.followers.include?(michael)
  #   # michael.unfollow(archer)
  #   # assert_not michael.following?(archer)
  # end

  test "associated challenges should be destroyed" do
    @user.save
    @user.daily_challenges.create!(postStatus: true, thirtyDates: Time.zone.now)
    assert_difference 'DailyChallenge.count', -1 do
      @user.destroy
    end
  end


  # mekedem's code starts here
  test "max number of post suggetion should suggest the right users" do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)

    # Should suggest user who I am not following
    assert michael.suggest_user_by_number_of_post.include?(archer);

    # Should not suggest a user who doesn't have a post yet 
    assert_not archer.suggest_user_by_number_of_post.include?(lana);

    # Should return 1 suggestion since lana is following michael already
    assert_equal lana.suggest_user_by_number_of_post.count, 1

    # Suggested users are not among users that michael is currently following
    michael.suggest_user_by_number_of_post.each do |suggested_user|
      assert_not michael.following?(suggested_user);
      assert suggested_user.haikus.count > 0
    end
  end

  test "suggest who I am not following but followed by users I follow" do
    michael = users(:michael)
    lana = users(:lana)

    # should suggest user who is followed by another user I follow
    michael.suggest_user_through_users_am_following[0].each do |suggested|
      assert michael.following?(lana);
      assert lana.following?(suggested);
      assert_not michael.following?(suggested);
    end

  end

  test "suggest by tag who has posts with same tag as mine" do
    # Should suggest user who I am not following and who has the tag post
    assert @michael_with_tag.suggest_by_tags.include?(@archer_with_tag);

    # should not suggest user who doesn't have posts with same tag or who I am following
    assert_not @michael_with_tag.suggest_by_tags.include?(@lana_with_tag);

    #each suggested user must be users who am not following
    @michael_with_tag.suggest_by_tags.each do |suggestedusr|
      assert_not @michael_with_tag.following?(suggestedusr);
    end

  end
  # mekedem's code ends here
end
