class DailyChallengesController < ApplicationController
  def index
    @user = current_user
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
