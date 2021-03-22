class ChallengesController < ApplicationController
    before_action :logged_in_user, only: [:challenge_user, :show ]
    before_action :correct_user, only: [:destroy]
    def challenge_user
        if logged_in?
            @reaction = Reaction.new
            @comment = Comment.new
            @haiku_comment = HaikuComment.new
            @micropost = current_user.microposts.build
            @haiku = current_user.haikus.build
            @haiku_feed_items = Haiku.where("public = ?", true).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            @challenge = current_user.challenges.last
            @challenges = current_user.challenges
            if @challenge
                @challenged_users_for_this_challenge = ChallengeUser.where("challenge_id = ?", @challenge.id)
                @challenged_users_for_this_challenge_name = []
                if @challenged_users_for_this_challenge.any?
                    @challenged_users_for_this_challenge.each do |challenge_user| 
                        user = User.find_by(id: challenge_user.user_id)
                        @challenged_users_for_this_challenge_name.push(user.name)
                    end
                end
            end
            @after_search_user = false
            
            
        end
    end
    def show 
        if logged_in?
            @reaction = Reaction.new
            @comment = Comment.new
            @haiku_comment = HaikuComment.new
            @micropost = current_user.microposts.build
            @haiku = current_user.haikus.build
            @haiku_feed_items = Haiku.where("public = ?", true).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
            @challenge = current_user.challenges.last
            @challenges = current_user.challenges
            if @challenge
                @challenged_users_for_this_challenge = ChallengeUser.where("challenge_id = ?", @challenge.id)
                @challenged_users_for_this_challenge_name = []
                if @challenged_users_for_this_challenge.any?
                    @challenged_users_for_this_challenge.each do |challenge_user| 
                        user = User.find_by(id: challenge_user.user_id)
                        @challenged_users_for_this_challenge_name.push(user.name)
                    end
                end
            end
            @after_search_user = false
        end
    end
    def destroy 
        @challenge.destroy
        if params[:submit_button] == "Delete"
            flash[:danger] = "Challenge deleted Successfully."
            redirect_to request.referrer || root_url
        else
            flash[:danger] = "Challenge Cancelled Successfully."
            redirect_to root_url
        end
    end
    private
        def correct_user
            @challenge = current_user.challenges.find_by(id: params[:challenge_id])
            redirect_to root_url if @challenge.nil?
        end
end
