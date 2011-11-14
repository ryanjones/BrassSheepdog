class RoadwayAlertSubscription < ActiveRecord::Base
  attr_accessible :last_roadway_update_sent, 
                  :alert_type
  
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
    
    #only send informatio for which the user is interested
    if (self.winter_parking_ban && alert_type == 'Winter Parking Ban')
      message += "Winter Parking Ban Alert as of " # + time sent        
    end
    if (self.residential_snow_maintenance && alert_type == 'Residential Snow Maintenace')
      message += "Residential Snow Maintenace Alert as of " # + time sent        
    end
    if (self.spring_street_cleaning && alert_type == 'Spring Street Cleaning')
      message += "Spring Street Cleaning Alert as of " # + time sent     
    end
    
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    "An Alert has been sent from the city!"
  end
  
  def next_alert_time
    "When COE issues an alert"
  end

  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the necessary conditions
    # in order of increasing cost
    self.enabled? && alert_received?
  end
  
  private 

    def alert_received?
      roadway_alerts = RoadwayAlerts.all
      
      #psuedo code for now
      if (alert_type == winter_parking_ban)
        self.alert_type = 'Winter Parking Ban'
      end
      if (alert_type == residential_snow_maintenance)
        self.alert_type = 'Residential Snow Maintenace'     
      end
      if (alert_type == spring_street_cleaning)
        self.alert_type = 'Spring Street Cleaning'
      end
      
      # Get the most recent UNSENT Alert (if we get 2 alerts within 2 minutes
      # we need to be send an alert for the first one, and then send another alert
      # in 30 minutes (going to have to be some epic time logic here))
      
      # either that or edit the delivery routine to do a "for each" email alert
      
    end
  
  
end
