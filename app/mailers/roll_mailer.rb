class RollMailer < ActionMailer::Base
  default from: 'info@zapfoto.com'

  def roll_email user_id, roll_id
    @user = User.find user_id
    @roll_id = roll_id
    mail(to: @user.email, subject: 'Your Zapfoto Contact Sheet')
  end
end
