class UserMailer < ActionMailer::Base
  # EDIT HERE
  # layout 'mail_layout'
  default from: "from@example.com"
    
  # Usage: UserMailer.test_mail(User.last).deliver
  def test_mail(user)
    mail(:to => user.email, :subject => "this is test mail.")
  end

  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end                                                                 


