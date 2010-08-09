class GarbageSubscription < ServiceSubscription
  attr_accessible :zone, :day
  
  validates_presence_of :zone
  validates_presence_of :day
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    #first check whether the time approximately matches the delivery time
  end

end
