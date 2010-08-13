class GarbageSubscription < ServiceSubscription
  attr_accessible :formatted_zone, :delivery_time, :day_before
  
  validates_presence_of :zone, :on => :update
  validates_presence_of :day, :on => :update
  validates_presence_of :delivery_time, :on => :update
  validates_presence_of :day_before, :on => :update
  
  #hard-coding the valid zones for now, this might need to change
  #if we want to support more cities, but auto-importing from 
  #the data set
  VALID_ZONES = ['A1', 'A2', 'B2', 'B3', 'B4', 'C4', 'C5', 'D5', 'D6', 'D7', 'E7', 'E8'].freeze

  #define a class method to check the validity of a zone
  def self.valid_zone?(zone)
    GarbageSubscription::VALID_ZONES.include?(zone)
  end
  
  #define a class method to check the validity of a zone
  def self.valid_zones
    GarbageSubscription::VALID_ZONES
  end  
  
  #set up a pseudo property for the formatted zone
  def formatted_zone 
    self.zone + self.day.to_s
  end
  
  def formatted_zone=(new_zone)
    self.zone = new_zone[0].chr
    self.day = new_zone[1].chr
  end
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost
    self.enabled? && self.approximately_now? && pickup_today?
  end
  
  private 
    def pickup_today?
      # this has been refactoed to handle the "day_before" setting
      now = DateTime.now
      #define the day to check
      if self.day_before
        # if they want the update the day before, we're interested in whether there's a pickup tomorrow
        day_of_interest = 1.day.since(now).to_date
      else 
        # if they want the update the the day of, we're interested in whether there's a pickup today
        day_of_interest = now.to_date
      end
      
      GarbagePickup.pickup_on_day? self.zone, self.day, day_of_interest
    end
  
end
