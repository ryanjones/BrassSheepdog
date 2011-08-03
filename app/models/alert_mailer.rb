class AlertMailer < ActionMailer::Base
  def alert_email(user, content, subject = nil)
    setup_email(user)
    if subject
      subject "Alertzy Alert - " + subject
    else
      subject "Alertzy Alert"
    end
    
    content_type "multipart/alternative"

    part "text/plain" do |p|
      p.body = render("alert_email_text", :locals => {:content => content})
      p.content_transfer_encoding = "base64"
    end
    
    part :content_type => "text/html",
      :body => render("alert_email_html", :locals => {:content => content})
  end
  
  def setup_email(user)
    recipients   "#{user.email}"
    from         "Alertzy.com Update" "<updates@alertzy.com>"
    subject      ""
    sent_on      Time.now
  end
end
