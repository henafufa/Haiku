class ChallengesController < ApplicationController
    before_action :logged_in_user, only: [:challenge_user ]
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
            @challenged_users_for_this_challenge = ChallengeUser.where("challenge = ?", @challenge.id)
            @after_search_user = false
            @challenged_users_for_this_challenge = ChallengeUser.where("challenge_id = ?", @challenge.id)
            @challenged_users_for_this_challenge_name = []
            @challenged_users_for_this_challenge.each do |challenge_user| 
                user = User.find_by(id: challenge_user.user_id)
                @challenged_users_for_this_challenge_name.push(user.name)
            end
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
            @after_search_user = false
            @challenged_users_for_this_challenge = ChallengeUser.where("challenge_id = ?", @challenge.id)
            @challenged_users_for_this_challenge_name = []
            @challenged_users_for_this_challenge.each do |challenge_user| 
                user = User.find_by(id: challenge_user.user_id)
                @challenged_users_for_this_challenge_name.push(user.name)
            end
        end
    end
end
