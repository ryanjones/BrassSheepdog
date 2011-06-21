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
      p.body = render_message("alert_email_text", :content => content)
      p.transfer_encoding = "base64"
    end
    
    part :content_type => "text/html",
      :body => render_message("alert_email_html", :content => content)
  end
  
  def setup_email(user)
    recipients   "#{user.email}"
    from         "Alertzy.com Update" "<updates@alertzy.com>"
    subject      ""
    sent_on      Time.now
  end
end
