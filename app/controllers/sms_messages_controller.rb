class SmsMessagesController < ApplicationController
  before_filter :login_required
  before_filter :set_header_link_class
  
  
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
    
    def set_header_link_class 
      @header_link_class = "send-message"
    end

end