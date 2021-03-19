class StaticPagesController < ApplicationController
  def home
   
    if logged_in?
      today = Time.zone.now.to_date
      @postStatus = DailyChallenge.where(user_id: current_user.id, thirtyDates: today.midnight..today.end_of_day)
      # p "postStatus#{@postStatus.first.postStatus}"
      if current_user.challenge_mode && !@postStatus.first.postStatus
       ActionCable.server.broadcast("remainder_channel","Hi #{current_user.name}, You didin't post today, dont forgot to post your haiku!")
      end
      @reaction = Reaction.new
      @haiku_reaction = HaikuReaction.new

      @comment = Comment.new
      @haiku_comment = HaikuComment.new
      @micropost = current_user.microposts.build
      @haiku = current_user.haikus.build
      @from_challenge = false
      # @haiku_feed_items = current_user.haiku_feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
      @haiku_feed_items = Haiku.where("public = ?", true).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)

      #here starts mekedems code
      @suggested_by_post = current_user.suggest_user_by_number_of_post() - current_user.suggest_user_through_users_am_following()[0];
      @suggested_by_user = current_user.suggest_user_through_users_am_following();
      # @suggested_user_from = current_user.suggest_user_through_users_am_following()[1];
      #here ends mekedems code
    else
      @haiku_feed_items = Haiku.where("public = ?", true).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def test
    render 'test'
  end
end
