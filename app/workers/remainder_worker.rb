class RemainderWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform()
        puts "SIDEKIQ WORKER GENERATING A REPORT"        
    end
end