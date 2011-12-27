class ContactMailer < ActionMailer::Base

  def contact_form(contact)
    mail(:to => "general@alertzy.com",
         :from => "updates@alertzy.com",
         :subject => "#{contact.subject}", 
         :body => "Name:#{contact.name} Email:#{contact.email} Message:#{contact.message}")
  end
  
  def contact_admins(error_class, error)
    mail(:to => "ryan.michael.jones@gmail.com, ben@zittlau.ca",
     :from => "updates@alertzy.com",
     :subject => "Error via => #{error_class}", 
     :body => "#{error}! Investigation ACTIVATE!!!")
  end
  
end
