class UserMailer < ActionMailer::Base
  def registration_notification(user)
    setup_email(user)
    subject    "Thank you for registering for Alertzy!"
    content_type "multipart/alternative"
    
    part :content_type => "text/html",
      :body => render_message("registration_notification_html", :user => user)

    part "text/plain" do |p|
      p.body = render_message("registration_notification_text", :user => user)
      p.transfer_encoding = "base64"
    end
  end
  
  def reminder_email(user)
    setup_email(user)
    subject "Alertzy Forgotten Login/Password"
    content_type "multipart/alternative"
    
    part :content_type => "text/html",
      :body => render_message("reminder_email_html", :user => user)

    part "text/plain" do |p|
      p.body = render_message("reminder_email_text", :user => user)
      p.transfer_encoding = "base64"
    end
  end
  
  def setup_email(user)
    recipients   "#{user.email}"
    from         "Alertzy.com Update" "<updates@alertzy.com>"
    subject      ""
    sent_on      Time.now
  end
end
