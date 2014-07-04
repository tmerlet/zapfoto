class MailWorker
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform user_id, roll_id
    RollMailer.roll_email(user_id, roll_id).deliver
  end
end
