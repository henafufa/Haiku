require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @haiku_reaction = haiku_reactions(:one)
    @haiku_comment = haiku_comments(:old_comments)
    @relationship = relationships(:three)
    @challenge_user = challenge_users(:three)
    @react_nontification = @user.notifications.build(message: "#{@haiku_reaction.user.name} reacted to your post", 
    notification_type: "haiku_reaction", haiku_reaction: @haiku_reaction)
    @comment_notification = @user.notifications.build(message: "#{@haiku_comment.user.name} commented on your post",
     notification_type: "haiku_comment", haiku_comment: @haiku_comment)
    @relationship_notification = @user.notifications.build(message: "#{@relationship.follower.name} started following your",
     notification_type: "relationship", relationship: @relationship)

     @challenge_user_notification = @user.notifications.build(message: "#{@challenge_user.user.name} sent you a challenge", 
      notification_type: "challenge_user", challenge_user: @challenge_user)
    

  end

  test "react notification should be valid" do
    assert @react_nontification.valid?
  end

  test "comment notification shoud be valid" do
    assert @comment_notification.valid?
  end

  test "relationship notification shoud be valid" do
    assert @relationship_notification.valid?
  end

  test "challenge user notification should be valid" do
    assert @challenge_user_notification.valid?
  end
end
