class UserMailer < ActionMailer::Base
  default :from => "Alertzy.com Update <update@alertzy.com>", :subject => ""

  def registration_notification(user)
    subject = "Thank you for registering for Alertzy!"
    
    @user = user

    mail(:to => "#{user.email}",
         :subject => subject)

  end
  
  def reminder_email(user)
    subject = "Thank you for registering for Alertzy!"
    
    @user = user

    mail(:to => "#{user.email}",
         :subject => subject)
  end
end
