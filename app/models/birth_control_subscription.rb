class BirthControlSubscription < ServiceSubscription
  
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
    #gotta calculate the next day here
    "CALC NEXT DAY"
  end
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost

    self.enabled? && approximately_now? && birth_control_now?
  end
  
  private 
   def birth_control_now?
      # this has been refactored to handle the "day_before" setting
      now = DateTime.now.in_time_zone
      #define the day to check
      if self.day_before
        # if they want the update the day before, we're interested in whether there's a pickup tomorrow
        day_of_interest = 1.day.since(now).to_date
      else 
        # if they want the update the the day of, we're interested in whether there's a pickup today
        day_of_interest = now.to_date
      end

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
