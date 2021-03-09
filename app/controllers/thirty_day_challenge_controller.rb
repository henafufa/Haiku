class ThirtyDayChallengeController < ApplicationController

    def index
        @microposts= current_user.microposts
        # @startDate=@micropost[start_date]
        @startDate = Micropost.select('start_date').where("user_id = ?  ", current_user.id)
        @chalengeCount = Micropost.where("user_id = ?", current_user.id).count
        @challengePosts= @microposts.where('created_at BETWEEN ? AND ? ', DateTime.now.beginning_of_month - 1.month, Time.zone.now)
        @postCount= @microposts.where('created_at BETWEEN ? AND ? ',Time.zone.now, Time.zone.now).count
    end

    def getStartDate
        
        # @startDate=  @microposts.select('start_date').where('start_date' != nil)
        # @micropost =  @microposts.where( @microposts[start_date] != nil )
    end

end
