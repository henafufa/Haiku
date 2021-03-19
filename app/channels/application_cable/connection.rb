module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include SessionsHelper
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.name
    end

    protected

    def find_verified_user
      if logged_in?
        p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-------------user exist"
      end
      verified_user = User.find_by(id: cookies.signed['user.id'])
      p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$verified_user----------------------#{verified_user}"
      if verified_user && cookies.signed['user.expires_at'] > Time.now
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
