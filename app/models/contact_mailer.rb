class ContactMailer < ActionMailer::Base

  def contact_form(contact)
    subject = "Contact Form Submission TEST"
    
    mail(:to => "ryan.michael.jones@gmail.com",
         :from => "updates@alertzy.com",
         :subject => subject, 
         :body => contact.message)
  end
  
end
