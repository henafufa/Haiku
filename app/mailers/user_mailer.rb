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

  def mail_gun_account_activation(user)
    @user = user
    api_key = ENV['MAILGUN_API_KEY']
    mg_client = Mailgun::Client.new api_key
    mail_from = "swengineer3.whizkids@gmail.com"
    mail_to = user.email
    message_params = {:from => mail_from,
                      :to => mail_to,
                      :subject => "Sample App User Activation",
                      :text => "Welcome to the Sample App! Click on the link below to activate your account: #{edit_account_activation_url(@user.activation_token, email: @user.email)}"}
    domain = ENV['MAILGUN_DOMAIN']
    mg_client.send_message domain, message_params
  end
  


  def mail_gun_password_reset(user)
    @user = user
    api_key = ENV['MAILGUN_API_KEY']
    mg_client = Mailgun::Client.new api_key
    mail_from = "swengineer3.whizkids@gmail.com"
    mail_to = user.email
    message_params = {:from => mail_from,
                      :to => mail_to,
                      :subject => "Sample App Password Reset",
                      :text => "To reset your password click the link below:
                      your account: #{edit_password_reset_url(@user.reset_token, email: @user.email)}. This link will expire in two hours. If you did not request your password to be reset, please ignore this email and your password will stay as it is."}
    domain = ENV['MAILGUN_DOMAIN']
    mg_client.send_message domain, message_params
    
  end

end
