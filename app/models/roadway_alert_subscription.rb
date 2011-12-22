class RoadwayAlertSubscription < ServiceSubscription
  attr_accessible :last_roadway_update_sent,
                  :time_alert_sent_by_coe,
                  :winter_parking_ban,
                  :in_effect
                  
  
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
  
  #hardcode the service if not set (must be singular like the model)
  def service
      self.original_service or Service.find_by_name("RoadwayAlert")
  end
  
  #define the message which will get sent to the uer
  def alert_content
    message = String.new
    
    # add 8 hours to the alert ( min 8 hours warning via the city) and apply a sexy format
    time_plus_8 = (@time_alert_sent_by_coe + 8.hours).to_formatted_s(:long_ordinal)

    if @in_effect == true
      message = "Seasonal parking ban issued. Begins as of #{time_plus_8}"
    else
      message = "Seasonal parking ban retracted. You can park after #{time_plus_8}"
    end
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    if @in_effect == true
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
      recent_roadway_alert = RoadwayAlert.find(:first, :order =>"atom_modified DESC")

      # Check if an alert has been sent to us before
      if self.last_roadway_update_sent.nil?
        # We've never received an alert so we deff need to send one
        @time_alert_sent_by_coe = recent_roadway_alert.atom_modified
        @in_effect = recent_roadway_alert.in_effect
        self.save! #save changes
        send_alert = true
      else
        # Check if we need to send a new alert
        if recent_roadway_alert.atom_modified.to_datetime > self.last_roadway_update_sent
          @time_alert_sent_by_coe = recent_roadway_alert.atom_modified
          @in_effect = recent_roadway_alert.in_effect
          self.save! #save changes
          send_alert = true
        end
      end
      
      send_alert
    end
  
  
end
