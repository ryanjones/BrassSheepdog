class GarbageSubscription < ServiceSubscription
  attr_accessible :formatted_zone, :delivery_time, :day_before, :address_attributes, :manual_zone
  
  belongs_to :address
  accepts_nested_attributes_for :address
  
  before_save :update_zone_if_required
  
  validates_presence_of :zone, :on => :update
  validates_presence_of :day, :on => :update
  validates_presence_of :delivery_time, :on => :update
  validates_inclusion_of :day_before, :in => [true, false]
  validate :must_have_valid_zone
  
  #being used for method to over-ride the service
  alias_method :original_service, :service
  alias_method :original_address, :address
  
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
  
  #hardcode the service
  def service_id
    self[:service_id] or self.service.id
  end
  
  #hardcode the service if not set
  def service
      self.original_service or Service.find_by_name("Garbage")
  end
  
  def address
    self.original_address or self.build_address
  end
  
  #define the message which will get sent to the uer
  def sms_content
    "Remember to take out your garbage!\nSent by Alertzy"
  end
  
  #set up a pseudo property for the formatted zone
  def formatted_zone
    self.zone + self.day.to_s unless !(self.zone && self.day)
  end
  
  def formatted_zone=(new_zone)
    self.zone = new_zone[0].chr
    self.day = new_zone[1].chr
  end
  
  #method to determine when the next update for this subscription will be
  def next_alert_time
    pickup_time = GarbagePickup.next_pickup self.zone, self.day
    pickup_day = pickup_time.to_date
    
    alert_day = (self.day_before ? 1.day.until(pickup_day) : pickup_day)
    alert_time = (self.delivery_time.to_i - self.delivery_time.to_date.to_time.to_i).seconds.since(alert_day)
  end
  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost
    self.enabled? && self.approximately_now? && pickup_today?
  end
  
  private 

    #this could be made more efficient by only occuring when the address changes
    def update_zone_if_required
      unless self.manual_zone || self.address.nil?
        garbage_zone = GarbageZone.find_address_zone(self.address)
        unless garbage_zone.nil?
          self.zone = garbage_zone.zone
          self.day = garbage_zone.day
        else
          errors.add_to_base("We couldn't find your zone.  Please check your address, or set manually.")
          false
        end
      end
    end
    
  
    def must_have_valid_zone
      errors.add_to_base("You must select a valid zone") unless GarbageSubscription.valid_zones.include?(self.formatted_zone)
    end
  
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
