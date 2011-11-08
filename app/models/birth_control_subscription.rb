class BirthControlSubscription < ServiceSubscription
  attr_accessible :pill_day, :pill_length, :pill_delivery_time
  
  validates_presence_of :pill_day
  validates_presence_of :pill_length
  validates_presence_of :pill_delivery_time
  
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
    # gotta set the day to take also
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    "Time to take your Birth Control Pill!"
  end
  
  def next_alert_time
    pickup_time = self.pill_delivery_time.to_time
    pickup_day = self.pill_delivery_time.to_date
    
    alert_day = pickup_day + 1.day
    alert_time = (self.pill_delivery_time.hour * 3600 + self.pill_delivery_time.min * 60 + self.pill_delivery_time.sec).seconds.since(alert_day).in_time_zone
    
    alert_time.strftime("%I:%M %p %a, %b, #{alert_time.to_time.day.ordinalize} %Y")
  end
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost
    self.enabled? && approximately_now? && birth_control_now?
  end
  
  private 
    def birth_control_now?
      self.send_reminder? pill_day, pill_length, pill_delivery_time
    end
    
    def send_reminder?
      
      
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
