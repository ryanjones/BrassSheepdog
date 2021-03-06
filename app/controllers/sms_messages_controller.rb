class SmsMessagesController < ApplicationController
  before_filter :login_required, :except => [:incoming]
  before_filter :http_basic_auth, :only => [:incoming]
  before_filter :set_header_link_class

  #action to handle incoming messages from the gateway
  def incoming
    message = params[:Body]
    # cut off the +1 from the phone number for a legit phone number
    from_number = params[:From].to_s.sub('+1', '')
    
    #if the user sent a message for info
    if /info/i.match(message)
      SmsMessage.send_info_message_to_phone_number(from_number)
    elsif /stop/i.match(message)
      user = User.find_by_phone_number(from_number)
      user.disable_all_alerts unless user.nil?
      SmsMessage.send_disabled_message_to_phone_number(user.phone_number)
    end
    
    # send emtpty response to twilio (since we reply to the request above)
    render :text => '<?xml version="1.0" encoding="UTF-8"?><Response></Response>'
  end
  
  def new
    @sms_message = SmsMessage.new
  end

  def create
    @sms_message = SmsMessage.new(params[:sms_message])
    success = @sms_message.valid? && @sms_message.send_message!
    if success && @sms_message.errors.empty?
      flash.now[:notice] = "Your message has been sent!"
      @sms_message = SmsMessage.new
      render :action => 'new'
    else
      flash.now[:error]  = "We couldn't send your message.  Please try again!"
      render :action => 'new'
    end
  end

  private
    # only allow admins to send messages directly
    def authorized?
      current_user.admin?
    end
    
    def http_basic_auth
      # Just basic authentication for now
      # alertzy / the normal PW
      authenticate_or_request_with_http_basic do |username, password|
        username == "aa3d56897dbf2a187a55421332dd4632" && password == "6a1368ad8685e957f33654ca3663ec43"
      end
    end
    
    def set_header_link_class 
      @header_link_class = "send-message"
    end

end