module NotificationsHelper
    include SessionsHelper

    def count_notification
        count_notification = Notification::where(user_id: current_user.id, is_seen: false)
        count_notification.count
    end
    def notifications
        @notifications = Notification::where(user_id: current_user.id)
    end
end
