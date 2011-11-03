class PagesController < ApplicationController
  layout :resolve_layout

  set_tab :home, :only => :home
  set_tab :services, :only => :services
  set_tab :about, :only => :about
  set_tab :contact, :only => :contact
  set_tab :faq, :only => :faq

  def home
    @title = "Updates and Alerts right to your phone!"
    @description = "Alertzy provides free sms-updates for Edmonton residents from our services.  Our services include Garbage Pickup schedules, sports field closures, and many more are coming soon."
  end
  
  def services
    @title = "Our current services"
    @description = "View Alertzy's available services and their descriptions.  Here you can find out the great services available to Alertzy users."
  end

  def about
    @title = "About this thing called Alertzy"
    @description = "All about the history of Alertzy and the hard working individuals who built it."
  end

  def contact
    @title = "How to get ahold of us"
    @description = "The contact information to reach the Alertzy team."
    @contact = Contact.new
  end
  
  def contact_submit
    @contact  = Contact.new(params[:contact])
    
    if @contact.valid?
      ContactMailer.contact_form(@contact).deliver
      flash.now[:notice] = "Thanks for contacting us! We'll respond as soon as possible."
      @contact = Contact.new
      render :action => 'contact'
    else  
       flash.now[:error] = "Sorry we\'re unable to process the contact request. Please fix the fields below:"
       render :action => 'contact'
    end
  end

  def faq
    @title = "You've got questions..."
    @description = "A collection of common questions which users of Alertzy have, and their answers."
  end

  private
  def resolve_layout
    case action_name
    when "home"
      "home"
    else
      "pages"
    end
  end
end
