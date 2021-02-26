class UserMailer < ApplicationMailer
  require 'mailgun-ruby'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
  def send_notification(user)
    # api_key = ENV['MAILGUN_API_KEY']
    mg_client = Mailgun::Client.new 'cf19e4bfdda9c04ad883582473c25234-6e0fd3a4-9206e612'
    mail_from = "tv.tsehai@gmail.com"
    mail_to = user.email
    message_params = {:from => mail_from,
                      :to => mail_to,
                      :subject => "Micropost User Activation",
                      :text => "Dear Admin, a new customer has just been registered."}
    domain = ENV['MAILGUN_DOMAIN']
    mg_client.send_message domain, message_params
  end
  
end
