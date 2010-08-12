class GarbageSubscription < ServiceSubscription
  
  attr_accessible :zone, :day
  
  validates_presence_of :zone, :on => :update
  validates_presence_of :day, :on => :update
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost
    self.enabled? && self.approximately_now? && pickup_today?
  end
  
  private 
    def pickup_today?
      # this will need to get more intelligent in order to better handle
      # timezones so that the notice always comes before the pickup date
      # in particular look at the case of a notification at midnight
      now = DateTime.now
      #define the date range to check
      today = now.to_date
      tomorrow = 1.day.since(now).to_date
  
      #return true if there is a pickup today, false if it's empty
      GarbagePickup.find(:all, 
                          :conditions => {:pickup_date => today..tomorrow, 
                                          :zone =>        self.zone,
                                          :day =>       self.day}).present?
    end
  
end
