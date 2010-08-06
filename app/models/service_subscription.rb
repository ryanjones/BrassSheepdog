class ServiceSubscription < ActiveRecord::Base
	 	belongs_to  :user 
	 	belongs_to  :service
    
    validates_presence_of :user_id
    validates_presence_of :service_id
    
end
