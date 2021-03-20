require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @haiku_reaction = haiku_reactions(:one)
    @haiku_comment = haiku_comments(:old_comments)
    @react_nontification = @user.notifications.build(message: "#{@haiku_reaction.user.name} reacted to your post", notification_type: "haiku_reaction", haiku_reaction: @haiku_reaction)
    @comment_notification = @user.notifications.build(message: "#{@haiku_comment.user.name} commented on your post", notification_type: "haiku_comment", haiku_comment: @haiku_comment)

  end

  test "react notification should be valid" do
    assert @react_nontification.valid?
  end

  test "comment notification shoud be valid" do
    assert @comment_notification.valid?
  end
end
