class BirthControlSubscription < ServiceSubscription
  attr_accessible :pill_day, :pill_length, :pill_delivery_time
  
  #being used for method to over-ride the service
  alias_method :original_service, :service
  
  #hardcode the service
  def service_id
    self[:service_id] or self.service.id
  end
  
  #hardcode the service if not set
  def service
      self.original_service or Service.find_by_name("BirthControl")
  end
  
  #define the message which will get sent to the uer
  def alert_content
    message = String.new
    message = "Take your pill!" # set day here
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    "Time to take your Birth Control Pill!"
  end
  
  def next_alert_time
    #gotta calculate the next day here (display in service sub area)
    "CALC NEXT DAY AND PILL # TO SEND"
  end
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost

    self.enabled? && approximately_now? && birth_control_now?
  end
  
  private 
   def birth_control_now?
      #date = DateTime.now.in_time_zone.to_date
      #BirthControl.send_reminder?

    end
    
    def approximately_now?(current_time = DateTime.now)
      # determine how many seconds apart the delivery is from the current time
      # take the modulus to isolate time from days
      time_difference = (current_time.to_i - self.delivery_time.to_i) % 1.day
      #make sure that we are looking at the smallest difference ( think looping at midnight )
      if time_difference > 1.day / 2
        time_difference = time_difference - 1.day
      end
      # check if the difference is less than 15 minute
      time_difference.abs <= 15.minutes
    end
  
end
