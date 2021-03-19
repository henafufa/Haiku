module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.name
    end

    protected

    def find_verified_user
      user_id = cookies.encrypted[:user_id]
      verified_user = User.find_by(id: user_id)
      # verified_user = User.find_by(id: cookies.encrypted[:users_id])
      if verified_user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
