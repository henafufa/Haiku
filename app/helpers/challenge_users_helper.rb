module ChallengeUsersHelper
    def challenged_user?(challenge_id, user_id)
        if(ChallengeUser.find_by(challenge_id: challenge_id, user_id: user_id))
            return true
        else
            return false
        end
    end
end
