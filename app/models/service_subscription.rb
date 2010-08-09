class ServiceSubscription < ActiveRecord::Base
	 	belongs_to  :user 
	 	belongs_to  :service
    
    validates_presence_of :user_id
    validates_presence_of :service_id
    
    def alert_user?
      #Determines whether an alert should be sent to the user
      #Should be over-ridden in the subclasses, will return false by default
      false
    end
    
end
