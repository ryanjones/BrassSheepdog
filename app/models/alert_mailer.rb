class AlertMailer < ActionMailer::Base
  default :from => "Alertzy.com Update <update@alertzy.com>", :subject => ""

  def alert_email(user, content, subject = nil)
    if subject
      subject  = "Alertzy Alert - " + subject
    else
      subject  = "Alertzy Alert"
    end

    @content = content

    mail(:to => "#{user.email}",
         :subject => subject)

  end
end
