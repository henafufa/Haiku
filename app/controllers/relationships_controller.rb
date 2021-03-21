class RelationshipsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    def create
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
        # @relationship_controller = @user.notifications.build(message: "#{current_user.name} started following you", 
        #                             notification_type: "relationship", relationship: @relationship, is_seen: false)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end
    def destroy
        @user = Relationship.find(params[:id]).followed
        current_user.unfollow(@user)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end
end
