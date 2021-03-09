module ThirtyDayChallengeHelper

    def challenge_started?
       current_user.email == "example@railstutorial.org" 
    end
end
