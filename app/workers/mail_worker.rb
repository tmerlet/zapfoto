class MailWorker
  include Sidekiq::Worker
  sidekiq_options backtrace: true


  def perform id
    RollMailer.test_email(id).deliver
  end
end
