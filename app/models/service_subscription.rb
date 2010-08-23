class ServiceSubscription < ActiveRecord::Base
    attr_accessible :service_id, :enabled
  
	 	belongs_to  :user 
	 	belongs_to  :service
    
    validates_presence_of :user_id
    validates_presence_of :service_id
    validates_inclusion_of :enabled, :in => [true, false]

    # This is breaking partial paths
    def self.model_name
      # make children models use service subscriptions paths by default
      name = "service_subscription"
      name.instance_eval do
        def plural;   pluralize;   end
        def singular; singularize; end
        def partial_path; singularize; end
      end
      return name
    end
    
    # over-riding the default enabled getter so that all services are disabled
    # if the user is not verified
    def enabled
      if self.user.verified?
        self[:enabled]
      else
        false
      end
    end
    
    # Defines a method for pointing to the edit view partial
    def edit_partial 
      return 'edit_' + self.class.to_s.underscore
    end
    
    def alert_user?
      #Determines whether an alert should be sent to the user
      #Should be over-ridden in the subclasses, will return false by default
      false
    end
    
    def enabled?
        self.enabled
    end
    
    
    def approximately_now?(current_time = DateTime.now)
      # determine how many seconds apart the delivery is from the current time
      # take the modulus to isolate time from days
      time_difference = (current_time.to_i - self.delivery_time.to_i) % 1.day
      #make sure that we are looking at the smallest difference ( think looping at midnight )
      if time_difference > 1.day / 2
        time_difference = time_difference - 1.day
      end
      # check if the difference is less than 15 minute
      time_difference.abs <= 15.minutes
    end
    
end
