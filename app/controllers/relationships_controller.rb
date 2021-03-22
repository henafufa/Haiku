class RelationshipsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    def create
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
        @relationship = Relationship::where(follower_id: current_user.id, followed_id: @user.id)
        @relationship_notification = @user.notifications.build(message: "#{current_user.name} started following you", 
                                    notification_type: "relationship", relationship: @relationship[0], is_seen: false)
        @relationship_notification.save
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end
    def destroy
        @user = Relationship.find(params[:id]).followed
        @relationship = Relationship::where(follower_id: current_user.id, followed_id: @user.id)
        @relationship[0].destroy
        current_user.unfollow(@user)

        
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end
end
