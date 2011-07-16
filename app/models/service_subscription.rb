class ServiceSubscription < ActiveRecord::Base
    attr_accessible :service_id, :sms_enabled, :email_enabled
  
	 	belongs_to  :user 
	 	belongs_to  :service
    
    validates_presence_of :user_id
    validates_presence_of :service_id
    validates_inclusion_of :sms_enabled, :in => [true, false]
    validates_inclusion_of :email_enabled, :in => [true, false]

    # This is breaking partial paths
    def self.model_name
      # make children models use service subscriptions paths by default
      name = "service_subscription"
      name.instance_eval do
        def human; humanize; end
        def plural;   pluralize;   end
        def singular; singularize; end
        def partial_path; singularize; end
      end
      return name
    end
    
    # over-riding the default enabled getter so that all services are disabled
    # if the user is not verified
    def enabled
      self.sms_enabled? or self.email_enabled?
    end
    
    def enabled?
      self.enabled
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
    
    #require the user to be verified for sms updates
    def sms_enabled
      if self.user.verified?
        self[:sms_enabled]
      else
        false
      end
    end
    
    def sms_enabled?
      self.sms_enabled
    end
    
    #verification not required for email updates
    def email_enabled
      self[:email_enabled]
    end
    
    def email_enabled?
      self.email_enabled
    end
    
    #these function can be over-ridden in the STI children
    def next_alert_time
      false
    end
    
    def alert_sent
      true
    end
    
    def alert_subject
      nil
    end
    
end

