class DailyRemainderWorker
    include Sidekiq::Worker
    # include Sidetiq::Schedulable
    sidekiq_options :queue => :mailer

    # recurrence { daily }
    def perform()
       User.find_each do |user|
        DailyRemainderMailer.remainder_email(user)
       end
    end
end