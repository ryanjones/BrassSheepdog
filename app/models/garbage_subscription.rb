class GarbageSubscription < ServiceSubscription
  
  attr_accessible :zone, :day
  
  validates_presence_of :zone, :on => :update
  validates_presence_of :day, :on => :update
  validates_presence_of :delivery_time, :on => :update
  validates_presence_of :day_before, :on => :update
  
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
