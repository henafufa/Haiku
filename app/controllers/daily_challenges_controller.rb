class DailyChallengesController < ApplicationController
  def index
    # @dialyChallenge = DailyChallenge.new
    # # @challenges = current_user.daily_challenges
    # @challenger = DailyChallenge.where("user_id = ?", current_user.id)
    # @challengePostStatus =  @challenger .where("user_id = ? and postStatus = ?  ",current_user.id, true)
    # # @challengePostStatus =  @challenges .where("postStatus = ?  ", true)
   
    # if current_user.challenge_mode
    #   @daysUntilNow= @challengePostStatus.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
    #   @postedDaysCount =  @challenger .where("postStatus = ?  ",true).count
    #   # @postedDaysCount =  @challenger .where("postStatus = ?  ",true).count
    #   @postedInRow= @challengePostStatus.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
    #   @totalDays= @challenger.where('created_at BETWEEN ? AND ? ',current_user.challenge_start_date, Time.zone.now).count
    # end
    
  end

 

end
