# Preview all emails at http://localhost:3000/rails/mailers/daily_remainder_mailer
class DailyRemainderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/daily_remainder_mailer/remainder_email
  def remainder_email
    DailyRemainderMailer.remainder_email
  end

end
