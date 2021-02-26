class UserMailer < ApplicationMailer
  require 'mailgun-ruby'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    # mail to: user.email, subject: "Account activation"
    api_key = ENV['MAILGUN_API_KEY']
    mg_client = Mailgun::Client.new api_key
    mail_from = "swengineer1.whizkids@gmail.com"
    mail_to = user.email
    message_params = {:from => mail_from,
                      :to => mail_to,
                      :subject => "Micropost User Activation",
                      :text => "Hello, #{@user.name} please click here #{edit_account_activation_url(@user.activation_token, email: @user.email)} to acticvate your micro-post account"}
    domain = ENV['MAILGUN_DOMAIN']
    mg_client.send_message domain, message_params
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    api_key = ENV['MAILGUN_API_KEY']
    mg_client = Mailgun::Client.new api_key
    mail_from = "swengineer1.whizkids@gmail.com"
    mail_to = user.email
    message_params = {:from => mail_from,
                      :to => mail_to,
                      :subject => "Micropost Password reset link",
                      :text => "Hello, #{@user.name} your password reset link is here #{edit_password_reset_url(@user.reset_token, email: @user.email)} Please Don't forward this link to any one."}
    domain = ENV['MAILGUN_DOMAIN']
    mg_client.send_message domain, message_params
  end
  
  def send_notification(user)
    @user = user
    # api_key = ENV['MAILGUN_API_KEY']
    # mg_client = Mailgun::Client.new api_key
    # mail_from = "swengineer1.whizkids@gmail.com"
    # mail_to = user.email
    # message_params = {:from => mail_from,
    #                   :to => mail_to,
    #                   :subject => "Micropost User Activation",
    #                   :text => "click link #{edit_account_activation_url(@user., email: @user.email)}"}
    # domain = ENV['MAILGUN_DOMAIN']
    # mg_client.send_message domain, message_params
  end
  
end
