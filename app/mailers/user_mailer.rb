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
    mail_from = "Micropost"
    mail_to = user.email
    message_params = {:from => mail_from,
                      :to => mail_to,
                      :subject => "Micropost User Activation",
                      :html => " <h1>Micropost App</h1>
                      <p>Hi <%= @user.name %>,</p>
                        <p>
                        Welcome to the Micropost App! Click on the link below to activate
                        your account:
                        </p>
                        <a href=#{edit_account_activation_url(@user.activation_token, email: @user.email)}>Activate</a>
                      click here"}
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
    mail to: user.email, subject: "Password reset"
  end
  
  def send_notification(user)
    @user = user
    api_key = ENV['MAILGUN_API_KEY']
    mg_client = Mailgun::Client.new api_key
    mail_from = "swengineer1.whizkids@gmail.com"
    mail_to = user.email
    message_params = {:from => mail_from,
                      :to => mail_to,
                      :subject => "Micropost User Activation",
                      :text => "click link #{edit_account_activation_url(@user.activation_token, email: @user.email)}"}
    domain = ENV['MAILGUN_DOMAIN']
    mg_client.send_message domain, message_params
  end
  
end
