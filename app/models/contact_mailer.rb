class ContactMailer < ActionMailer::Base

  def contact_form(contact)

    mail(:to => "general@alertzy.com",
         :from => "updates@alertzy.com",
         :subject => "#{contact.subject}", 
         :body => "Name:#{contact.name} Email:#{contact.email} Message:#{contact.message}")
  end
  
end
