class ApplicationController < ActionController::Base
    include SessionsHelper
    include ChallengeUsersHelper
    # before_action :set_locale
    def application
        # render html:"Hello world"
    end
    def hello
        # render html:"Hello world"
    end
    private
    # Confirms a logged-in user.
    # def set_locale
    #     I18n.locale = extract_locale || I18n.default_locale
    # end
    # def extract_locale
    #     parsed_locale = params[:locale]
    #     I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    # end
    # def default_url_options
    #     { locale: I18n.locale }
    # end
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end
    
    
end
