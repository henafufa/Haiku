class DailyChallengesController < ApplicationController
  # before_action :getTotalDate
  def index
    @dialyChallenge = DailyChallenge.new
    @challenges = current_user.daily_challenges
    @challenger = DailyChallenge.where("user_id = ?", current_user.id)
    @challengePostStatus =  @challenges .where("user_id = ? and postStatus = ?  ",current_user.id, true)
    # @challengePostStatus =  @challenges .where("postStatus = ?  ", true)
   
    if current_user.challenge_mode
      @daysUntilNow= @challengePostStatus.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
      @postedDaysCount =  @challenges .where("postStatus = ?  ",true).count
      # @postedDaysCount =  @challenger .where("postStatus = ?  ",true).count
      @postedInRow= @challengePostStatus.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
      @totalDays= @challenges.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
    end
    # @challengeCount = Micropost.where("user_id = ?", current_user.id).count
    # @postCount= @microposts.where('created_at BETWEEN ? AND ? ',current_user.start_date, Time.zone.now).count
    # p "haiku--------------------#{@challenges.second.postStatus}"
    # p "haiku--------------------#{@challengePostStatus.first.postStatus }"
    p "challenger--------------------#{@challenger }"
    p "challenges--------------------#{@challenges }"
    p "daysUntilNow--------------------#{@daysUntilNow }"
    p "postedDays--------------------#{@postedDays }"
    p "totalDays --------------------#{@totalDays }"
    p "totalDays --------------------#{@postedDaysCount }"

    # @challengePosts= @microposts.where('created_at BETWEEN ? AND ? ', DateTime.now.beginning_of_month - 1.month, Time.zone.now)
  end

  def getTotalDate
    # @startDate= User.find(user_id: current_user.id)
  end

  def getTotalPostedDate
  end

  def getInrowPost
  end

  def create
    @challenge = DailyChallenge.new(challenge_params)
    if @challenge.save
      flash[:info] = "challenge updated"
      redirect_to daily_challenges_url
    else
      flash[:danger] = "Unable to update challenge"
    end
  end

  private 
  def challenge_params
    params.require(:challenge).permit(:user_id, :haiku_id, :postStatus, :thirtyDates)
  end

end
