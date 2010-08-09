class ServiceSubscription < ActiveRecord::Base
    attr_accessible :service_id, :delivery_time, :enabled
  
	 	belongs_to  :user 
	 	belongs_to  :service
    
    validates_presence_of :user_id
    validates_presence_of :service_id
    validates_presence_of :delivery_time
    validates_presence_of :enabled
    
    def alert_user?
      #Determines whether an alert should be sent to the user
      #Should be over-ridden in the subclasses, will return false by default
      false
    end
    
    
    def approximately_now?(current_time = DateTime.now)
      #get the seconds from the start of the day as we don't care about the day
      delivery_second_offset = self.delivery_time.to_i - self.delivery_time.to_date.to_time.to_i
      current_second_offset = current_time.to_i - current_time.to_date.to_time.to_i
      #determine how many seconds apart the delivery is from the current time
      time_difference = delivery_second_offset - current_second_offset
      #check if the difference is less than 15 minute
      time_difference.abs <= 15.minutes
      
      p time_difference
      p delivery_second_offset
      p current_second_offset
    end
    
end
