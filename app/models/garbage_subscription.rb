class GarbageSubscription < ServiceSubscription
  attr_accessible :zone, :day
  
  validates_presence_of :zone
  validates_presence_of :day
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    send_an_alert = false
    #first check whether the time approximately matches the delivery time
    if self.enabled? && self.approximately_now?
        # check if there is a garbage pickup today
        # this will need to get more intelligent to make sure we are on the right
        # side of the garbage pickup
        now = DateTime.now
        #define the date range to check
        today = now.to_date
        tomorrow = 1.day.since(now).to_date
      
        #unless there are no pickups today, send the user an alert 
        unless GarbagePickup.find(:all, 
                            :conditions => {:pickup_date => today..tomorrow, 
                                            :zone =>        self.zone,
                                            :day =>       self.day}).empty?
          send_an_alert = true
        end
      end
    return send_an_alert
  end
end
