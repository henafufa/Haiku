module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_notified_user
      logger.add_tags 'ActionCable', current_user.name
    end

    protected

    def find_notified_user
      # notified_user = User.find_by(id: cookies.encrypted[:user_id])
      notified_user = User.find_by(id: session[:user_id])
      p "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$verified_user----------------------#{notified_user}"
      if (user_id = session[:user_id])
        current_user = User.find_by(id: session[:user_id])
        current_user
      elsif (user_id = cookies.encrypted[:user_id])
        current_user = User.find_by(id: cookies.encrypted[:user_id])
        current_user
      else
        reject_unauthorized_connection 
      end
    end
  end
end
