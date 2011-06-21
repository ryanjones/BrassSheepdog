class PagesController < ApplicationController
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
  end

  def faq
    @title = "You've got questions..."
    @description = "A collection of common questions which users of Alertzy have, and their answers."
  end
end
