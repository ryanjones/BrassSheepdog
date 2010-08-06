class SmsMessagesController < ApplicationController
  def new
    @sms_message = SmsMessage.new
  end

  def create
    @sms_message = SmsMessage.new(params[:sms_message])
    success = @sms_message.valid? && @sms_message.send_message
    if success && @sms_message.errors.empty?
      flash.now[:notice] = "Your message has been sent!"
      render :action => 'new'
    else
      flash.now[:error]  = "We couldn't send your message.  Please try again!"
      render :action => 'new'
    end
  end

end
