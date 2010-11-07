class Delivery < ActiveRecord::Base
  def self.scheduled_events
    FieldStatus.update
    # ElectionResultSet.update
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
      user_subscription_array = user.service_subscriptions.find(:all, :joins => [:service], :conditions => ['`services`.enabled = ?', true])
      user_subscription_array.each do |subscription|
        logger.debug "Evaluating user"
        if subscription.alert_user?
          #send an sms message if they are enabled
          if subscription.sms_enabled?
            logger.debug "Sending Message"
            message_content = subscription.alert_content + "\nSent by Alertzy.com"
            s = SmsMessage.new(:phone_number => user.phone_number,
                           :content      => message_content)
            s.send_message!
            subscription.alert_sent
          end
          #send an email if they are enabled
          if subscription.email_enabled?
            logger.debug "Sending email to #{user.email}"
            AlertMailer.deliver_alert_email(user, subscription.alert_content, subscription.alert_subject)
          end
        end 
        
        # testing lewp
        # puts user.phone_number
        # puts subscription.name
      end
    end
  end
  
end