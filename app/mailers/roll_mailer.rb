class RollMailer < ActionMailer::Base
  default from: 'info@zapfoto.com'

  def test_email user_id
    @user = User.find user_id
    mail(to: @user.email, subject: 'Hope this works')
  end
end
