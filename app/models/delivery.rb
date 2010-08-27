class Delivery < ActiveRecord::Base
  def self.scheduled_events
    FieldStatus.update
    Delivery.check_subscription
  end
  
  def self.check_subscription
    # Get all of the users
    
    user_array = User.all
    
    # Cycle through the user array and user subscriptions
    user_array.each do |user|
      
      #set the users timezone
      Time.zone = user.time_zone
      
      # For each subscription, check if the delivery time ~now, if so send message
      user_subscription_array = user.service_subscriptions
      user_subscription_array.each do |subscription|
        logger.debug "Evaluating user"
        if subscription.alert_user?
          logger.debug "Sending Message"
          s = SmsMessage.new(:phone_number => user.phone_number,
                         :content      => subscription.sms_content)
          s.send_message!
          subscription.alert_sent
        end 
        
        # testing lewp
        # puts user.phone_number
        # puts subscription.name
      end
    end
  end
  
end