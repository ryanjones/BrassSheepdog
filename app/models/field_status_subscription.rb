class FieldStatusSubscription < ServiceSubscription
  attr_accessible :update_about_northeast, :update_about_northwest, :update_about_southside
  
  after_create :update_previous_values
  
  validates_inclusion_of :update_about_northeast, :in => [true, false]
  validates_inclusion_of :update_about_northwest, :in => [true, false]
  validates_inclusion_of :update_about_southside, :in => [true, false]
  validates_inclusion_of :send_only_on_change, :in => [true, false]

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
      self.original_service or Service.find_by_name("FieldStatus")
  end
  
  #define the message which will get sent to the uer
  def alert_content
    message = String.new
    #only send informatio for which the user is interested
    if (self.update_about_northeast)
      message += "Northeast fields are " + 
                  ((self.current_northeast_state == self.previous_northeast_state) ? "still" : "now") + " " +
                  ((self.current_northeast_state) ? "open." : "closed.") + "\n"
                  
    end
    if (self.update_about_northwest)
      message += "Northwest fields are " + 
                  ((self.current_northwest_state == self.previous_northwest_state) ? "still" : "now") + " " +
                  ((self.current_northwest_state) ? "open." : "closed.") + "\n"
                  
    end
    if (self.update_about_southside)
      message += "Southside fields are " + 
                  ((self.current_southside_state == self.previous_southside_state) ? "still" : "now") + " " +
                  ((self.current_southside_state) ? "open." : "closed.") + "\n"
                  
    end
    
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    "Field Statuses Have Changed!"
  end
  
  def next_alert_time
    "When a status changes"
  end

  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost
    self.enabled? && have_statuses_changed?
  end
  
  def update_previous_values
    latest_update = FieldStatus.latest_update
    
    self.previous_northeast_state = self.current_northeast_state
    self.previous_northwest_state = self.current_northwest_state
    self.previous_southside_state = self.current_southside_state
    
    self.current_northeast_state = latest_update.northeast_open
    self.current_northwest_state = latest_update.northwest_open
    self.current_southside_state = latest_update.south_open
    self.save
  end
  
  private 


  
    def have_statuses_changed?
      statuses_have_changed = false
      latest_update = FieldStatus.latest_update
      
      #check each region to see if it has changed and the user is subscribed to it
      if (latest_update.northeast_open != self.current_northeast_state) and self.update_about_northeast
        statuses_have_changed = true
      end
      
      if (latest_update.northwest_open != self.current_northwest_state) and self.update_about_northwest
        statuses_have_changed = true
      end
      
      if (latest_update.south_open != self.current_southside_state) and self.update_about_southside
        statuses_have_changed = true
      end
      
      update_previous_values
      
      return statuses_have_changed
      
    end
  
end
