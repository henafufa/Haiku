class ChallengeUsersController < ApplicationController
    include HaikusHelper
    before_action :logged_in_user, only: [:create, :destroy]
    def create
        @user = User.find(params[:user_id])
        @challenge_user = ChallengeUser.new(user_id: params[:user_id], challenge_id: params[:challenge_id])
        if @challenge_user.save
            @challenge_notification = @user.notifications.build(message: "#{current_user.name} sent you a challenge", 
                                        notification_type: "challenge_user", challenge_user: @challenge_user, is_seen: false)
            @challenge_notification.save
            redirect_to request.referrer || search_user_path
        else
            flash[:danger] = "Invalid challenge something wrong"
            redirect_to request.referrer 
        end
    end
    def destroy
        @challenge_user = ChallengeUser.find_by(user_id: params[:user_id], challenge_id: params[:challenge_id])
        @challenge_user.destroy
		redirect_to request.referrer || root_url
    end
    def show
        @from_challenge = true
        @my_challenges = []
        current_user.challenge_users.each do |challenge_user|
            challenge = Challenge.find_by(id: challenge_user.challenge_id)
            @my_challenges.push(challenge)
        end
        @haiku = Haiku.new
    end
    private
        def challenge_user_params
            params.require(:challenge_user).permit(:user_id, :challenge_id)
        end 
end
