class Delivery < ActiveRecord::Base
  def self.scheduled_events
    begin
      FieldStatus.update
    rescue
      ContactMailer.contact_admins("Field Satus", "Service update failed (getting the fields)")
    end
    
    begin
      RoadwayAlert.update
    rescue
      ContactMailer.contact_admins("Roadway Alert", "Service update failed (updating from gmail rss)")
    end
    # ElectionResultSet.update
    Delivery.check_subscription
  end
  
  def self.check_subscription
    # Get all twilio numbers
    sms_message = SmsMessage.new
    twilio_number_list = sms_message.twilio_numbers
    
    twilio_number_counter = 0 #used to count through the numbers
    
    # Get all of the users
    user_array = User.all
    
    # Cycle through the user array and user subscriptions
    user_array.each do |user|
      
      # set twilio # to use
      twilio_number = twilio_number_list[twilio_number_counter].phone_number

      # if we're at the end of the numbers, kick it back to the beginning of the list
      if (twilio_number_counter == twilio_number_list.count - 1)
        twilio_number_counter = 0
      else  
        # move the counter up the list of numbers
        twilio_number_counter = twilio_number_counter + 1
      end

      #set the users timezone
      Time.zone = user.time_zone
      
      # For each subscription, check if the delivery time ~now, if so send message
      user_subscription_array = user.service_subscriptions.find(:all, :joins => [:service], :conditions => ['`services`.enabled = ?', true], :readonly => false)
      user_subscription_array.each do |subscription|

        begin
          if subscription.alert_user?
            #send an sms message if they are enabled
            if subscription.sms_enabled?
              message_content = subscription.alert_content + "\nSent by Alertzy.com"
              s = SmsMessage.new(:phone_number => user.phone_number,
                             :content      => message_content,
                             :twilio_number => twilio_number)
              s.send_message!
            end
            #send an email if they are enabled
            if subscription.email_enabled?
              logger.debug "Sending email to #{user.email}"
              AlertMailer.alert_email(user, subscription.alert_content, subscription.alert_subject).deliver
            end
              # any actions needed after the alert is sent
              subscription.alert_sent
          end
        rescue
          ContactMailer.contact_admins(subscription.type, "A user's subscription failed. User_id = #{subscription.user_id}, #{subscription.type}_id = #{subscription.id}").deliver
        end   
      end
    end
  end
  
end
