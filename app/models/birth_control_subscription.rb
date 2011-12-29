class BirthControlSubscription < ServiceSubscription
  #updated_by_user is to ONLY be updated on the front end (through the view)
  attr_accessible :pill_day, :pill_length, :pill_delivery_time, :updated_by_user
  
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
    message = "Take birth control pill ##{self.pill_day} today!"
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    "Time to take your Birth Control Pill!"
  end
  
  def next_alert_time
    # Make time sexy
    dd = DateTime.parse(self.pill_delivery_time.to_s)
    tt = Time.parse(dd.to_s)
    # borat hahahahaha...
    sexy_time = tt.strftime("%I:%M%p")
    
    # Determine the next pill
    if self.pill_length == 28
      "Pill # #{self.pill_day + 1} at #{sexy_time}"
    elsif self.pill_length == 21 && self.pill_day >= 21
      "You're currently within your 7 day break"
    elsif self.pill_length == 21 && self.pill_day <= 21
      "Pill # #{self.pill_day + 1} at #{sexy_time}"
    end
  end
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost
    self.enabled? && approximately_now? && birth_control_now?
  end
  
  
  private 
    def birth_control_now?
      # Check if the updated at date is todays date. If they don't match update the pill # and save
      # We only send messages on the NEXT day from when they set there cycle
      # By Doing this we match the next_alert_time method
      
      # Scenarios:
      
      # User sets cycle before 7am (no message sent if updated today)
      #    cycle 10     
      #----------------7am---------------
      
      # User sets cycle after 7am (no message sent if updated today)
      #                     cycle 10
      #----------------7am---------------
      
      # User logs on BEFORE 7am and sees cycle 10 (she updates to cycle 11) (no message sent, updated today) 
      # This scenario would happen if they logged on before their message was sent for that day
      #      cycle 11
      #----------------7am---------------
      
      # User sets cycle to 7, then realizes she's actually on 8 and updates
      # (no message sent, updated today) 
      #      cycle 7         cycle 8
      #----------------7am---------------
      send_message = false
      
      
      # We increment the pill (cycle #) if the updated date != todays date
      unless self.updated_by_user.to_date == Date.today
        # If we're at 28 we need to go back to 1
        if self.pill_day == 28
          self.pill_day = 1
        else  
        # if we're not at 28, we increment by 1  
          self.pill_day += 1
        end
        
        # save the new pill day
        self.save
        
        # if they're on the 21 day cycle and the day <= 21, send reminder
        if self.pill_length == 21 && self.pill_day <= 21
          send_message = true
          
        # 28 day cycle gets a reminder every day
        elsif self.pill_length == 28
          send_message = true
        end
      end

      send_message
    end
    
    
    def approximately_now?(current_time = DateTime.now)
      # determine how many seconds apart the delivery is from the current time
      # take the modulus to isolate time from days
      time_difference = (current_time.to_i - self.pill_delivery_time.to_i) % 1.day
      #make sure that we are looking at the smallest difference ( think looping at midnight )
      if time_difference > 1.day / 2
        time_difference = time_difference - 1.day
      end
      # check if the difference is less than 15 minute
      time_difference.abs <= 15.minutes
    end
  
end
