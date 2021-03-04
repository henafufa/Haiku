class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @reaction = Reaction.new
      @comment = Comment.new
      @haiku_comment = HaikuComment.new
      @micropost = current_user.microposts.build
      @haiku = current_user.haikus.build
      @haiku_feed_items = current_user.haiku_feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
