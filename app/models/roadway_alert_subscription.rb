class RoadwayAlertSubscription < ActiveRecord::Base
  attr_accessible :last_roadway_update_sent,
                  :time_alert_sent_by_coe
  
  HUMANIZED_ATTRIBUTES = {
    }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  #being used for method to over-ride the service
  alias_method :original_service, :service
  
  #hardcode the service
  def service_id
    self[:service_id] or self.service.id
  end
  
  #hardcode the service if not set
  def service
      self.original_service or Service.find_by_name("RoadwayAlerts")
  end
  
  #define the message which will get sent to the uer
  def alert_content
    message = String.new
    
    if self.in_effect == true
      message = "Seasonal parking ban issued as of #{self.time_alert_sent_by_coe}"
    else
      message = "Seasonal parking ban retracted as of #{self.time_alert_sent_by_coe}"
    end
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    if self.in_effect == true
      message = "Seasonal parking ban issued from the city!"
    else
      message = "Seasonal parking ban retracted from the city!"
    end
  end
  
  def next_alert_time
    "When COE issues a Seasonal Parking Ban"
  end

  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the necessary conditions
    # in order of increasing cost
    self.enabled? && new_alert_received?
  end
  
  private 

    def new_alert_received?
      send_alert = false
      recent_roadway_alert = RoadwayAlerts.find(:first, :order =>"atom_modified DESC")
      
      # Check if we need to send a new alert
      if recent_roadway_alert.atom_modified > self.last_roadway_update_sent
        self.time_alert_sent_by_coe = recent_roadway_alert.atom_modified
        self.in_effect = recent_roadway_alert.in_effect
        send_alert = true
      end
      
      send_alert
    end
  
  
end
