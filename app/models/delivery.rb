class Delivery < ActiveRecord::Base
  
  def self.check_subscription
    # Get all of the users
    user_array = User.all
    
    # Cycle through the user array and user subscriptions
    user_array.each do |user|
      
      # For each subscription, check if the delivery time ~now, if so send message
      user_subscription_array = user.service_subscriptions
      user_subscription_array.each do |subscription|
        # if subscription.valid?
          # need to check how to create a new SmsMessage
          # s = SmsMessage.new
          # s.send_message(:phone_number => user.phone_number,
          #                :content      => subscription.sms_content)
        # end 
        
        # testing lewp
        # puts user.phone_number
        # puts subscription.name
      end
    end
  end
  
end