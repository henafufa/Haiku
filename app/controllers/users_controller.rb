class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show, :followers, :following ]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :challengeSummery
  before_action :getActivities

  def index
    # PublicActivity::Activity.new
    # @users = User.all
    # @users = User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
    
  end

  def getActivities
    @activities = PublicActivity::Activity.order('created_at desc').where(owner: current_user)
  end
  def show
    @comment = Comment.new
    @haiku_comment = HaikuComment.new
    @reaction = Reaction.new
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    # debugger
  end

  # challenge handler
  def dailyChallenge
    @dailyChallenge=DailyChallenge.new
    if current_user.update_columns(challenge_mode: true, challenge_start_date: Time.zone.now)
      flash[:success] = "Challnege Started!! post your first day challenge"
      x=0
      @challengeDates = Time.now + x.days
      # @challenge = current_user.daily_challenges.create(thirtyDates: Time.zone.now)
      30.times do |n|
        @challenge = current_user.daily_challenges.create!(thirtyDates: Time.zone.now + n.days)
        if @challenge.save
          flash[:success] = "challenge setted!"
          ++x
        else
          flash[:success] = "couldnt set challenge!"
        end
      end
      redirect_to request.referrer 
      # redirect_to daily_challenges_url
    else
      flash[:danger] = "Unable to start challenge"
    end
  end

  def challengeSummery
    @dialyChallenge = DailyChallenge.new
    @challenges = current_user.daily_challenges
    @startDate= User.where("id = ? ",current_user.id).select("challenge_start_date")
    @chalengeStartedDate= @startDate.first.challenge_start_date
    @currentDate= Time.zone.now
    @challenger = DailyChallenge.where("user_id = ?", current_user.id)
    @challengePostStatus =  @challenges .where("user_id = ? and postStatus = ?  ",current_user.id, true)
    # @challengePostStatus =  @challenges .where("postStatus = ?  ", true)
    if current_user.challenge_mode
      # @daysUntilNow= @challengePostStatus.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now + 1.days).count
      @daysUntilNow=  (@chalengeStartedDate - @currentDate)
      p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$----------------------#{@daysUntilNow}"
      p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ challenger----------------------#{@startDate.first.challenge_start_date}"
      @postedDaysCount =  @challenges .where("postStatus = ?  ",true).count
      # @postedDaysCount =  @challenger .where("postStatus = ?  ",true).count
      @postedInRow= @challengePostStatus.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
      @totalDays= @challenges.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def new
    @user = User.new
  end
  def private_post
    @comment = Comment.new
    @haiku_comment = HaikuComment.new
    @reaction = Reaction.new
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    # @microposts = @user.microposts.find(:all, :conditions => { :id => 2 }).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    @haiku = Haiku.where("user_id = ? and public = ?", @user.id, false).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)

  end
  def create
    # @user = User.new(params[:user]) # Not the final
    # implementation!
    @user = User.new(user_params)

    if @user.save
    # Handle a successful save.
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
      # UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page], :per_page => 10, :total_entries => 50)
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page], :per_page => 10, :total_entries => 50)
    render 'show_follow'
  end
  def search
    @reaction = Reaction.new
    @comment = Comment.new
    @haiku_comment = HaikuComment.new
    @micropost = current_user.microposts.build
    @haiku = current_user.haikus.build
    # @haiku_feed_items = current_user.haiku_feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    if params[:filter] && params[:filter] === 'Haiku'
      # @users = User.where("name LIKE ?", "%" + params[:search] + "%").paginate(page: params[:page])
      @haiku_feed_items = Haiku.where("user_id = ? and public = ? and verse_1 LIKE ? or verse_2 LIKE ? or verse_3 LIKE ?", current_user.id, true, "%"+params[:search]+"%", "%"+params[:search]+"%", "%"+params[:search]+"%").paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
      @is_on_search = true
      render '/static_pages/home'
    elsif params[:filter] && params[:filter] === 'Users'
      # Friend.where(["email LIKE ?", "% {params[:q]} %"])
      @is_on_search = true
      @users = User.where("email LIKE ?", "%" + params[:search] + "%").paginate(page: params[:page])
      render 'index'
      # @friends = Friend.search(params[:search])
    elsif params[:filter] && params[:filter] === 'Haiku by tag'
      @is_on_search = true
      # @users = User.where("name LIKE ?", "%" + params[:search] + "%").paginate(page: params[:page])
      @haiku_feed_items = Haiku.where("user_id = ? and public = ? and tag LIKE ?", current_user.id, true, "%"+params[:search]+"%").paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
      render '/static_pages/home'
    else
      @haiku_feed_items = Haiku.where("user_id = ? and public = ?", current_user.id, true).paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
      @is_on_search = false
      render '/static_pages/home'
      
    end
  end
  def search_activities
    @user = current_user
    @reaction = Reaction.new
    @comment = Comment.new
    @haiku_comment = HaikuComment.new
    @micropost = current_user.microposts.build
    @haiku = current_user.haikus.build
    # @haiku_feed_items = current_user.haiku_feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5, :total_entries => 30)
    # @activities = PublicActivity::Activity.order('created_at desc').where("owner_id = ? ", current_user.id)
    if params[:search] === 'posts'
      posts= 'Haiku'
      @activities = PublicActivity::Activity.order('created_at desc').where("owner_id = ? and trackable_type = ?", current_user.id, posts)
    elsif params[:search] === 'comments'
      comments= 'HaikuComment'
      @activities = PublicActivity::Activity.order('created_at desc').where("owner_id = ? and trackable_type = ?", current_user.id,comments)
    elsif params[:search] === 'likes'
      likes= 'HaikuReaction'
      @activities = PublicActivity::Activity.order('created_at desc').where("owner_id = ? and trackable_type = ?", current_user.id, likes)
    elsif params[:search] === 'follows'
      follows='Relationship'
      @activities = PublicActivity::Activity.order('created_at desc').where("owner_id = ? and trackable_type = ?", current_user.id, follows)
    else
      @activities = PublicActivity::Activity.order('created_at desc').where(owner: current_user)
    end
    p "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW---------------#{@activities.count}"
    render '/users/show'
  end

  def addRemainderToQueue
    DailyRemainderWorker.perform_async()
    render text: " REQUEST TO GENERATE A REPORT ADDED TO THE QUEUE"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
    # end
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    def search_params
      params.require(:search).permit(:filter, :search_value)
    
    end
end
