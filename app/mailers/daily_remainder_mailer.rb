class DailyRemainderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_remainder_mailer.remainder_email.subject
  #
  def remainder_email(user)
    @user = user
    mail to: user.email, subject:"Haiku Daily Remainder"
  end
end
