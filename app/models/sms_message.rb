# Example syntax of how to send a text message
# @sms_message = SmsMessage.new(:phone_number => "17807102820", :content => "hi")
# success = @sms_message.valid? && @sms_message.send_message!
require 'rexml/document'
require 'twilio-ruby'

class SmsMessage < Object
  include ActiveModel::Validations
  include ActiveModel::Naming
  include ActiveModel::Conversion
  
  attr_accessor :phone_number, :content
  
  validates_presence_of     :phone_number
  validates_numericality_of :phone_number, :only_integer => true
  validates_length_of       :phone_number, :is => 10, :message => "must be 10 digits"
  
  validates_length_of       :content, :maximum => 140
  validates_presence_of     :content
  
  #Moodified initialize to provide behavior closer to ActiveRecord::Base
  def initialize(attributes = nil)
    @phone_number = attributes[:phone_number] unless attributes.nil?
    @content = attributes[:content] unless attributes.nil?
  end
  
  # The obligatory messages for SMS requirements
  def self.send_info_message_to_phone_number(phone_number)
    @sms_message = SmsMessage.new(:phone_number => phone_number, :content => SmsMessage.info_message_content)
    success = @sms_message.valid? && @sms_message.send_message!
  end
  
  def self.info_message_content
    "Visit Alertzy.com for info and to change your settings."
  end
  
  def self.send_disabled_message_to_phone_number(phone_number)
    @sms_message = SmsMessage.new(:phone_number => phone_number, :content => SmsMessage.disabled_message_content)
    success = @sms_message.valid? && @sms_message.send_message!
  end
  
  def self.disabled_message_content
    "All your alertzy subscriptions have been disabled.\n  Visit Alertzy.com to change your settings or re-enable."
  end
  
  
  #Sends the text message to our message provider
  def send_message!
    #fail to send if the message doesn't pass validation
    return false unless self.valid?
    #otherwise continue to send the message
    
    #build args for twilio
    post_args = {
      :from => '+19519994321',
      :to => "1#{self.phone_number}",
      :body => self.content
    }
    
    unless (defined?(FAKE_SMS_MESSAGES) && FAKE_SMS_MESSAGES)
      submit_to_gateway!(post_args)
    else
      fake_submit_to_gateway!(post_args)
    end

  end
  
  #This model will always report being a new record
  def new_record?
    true
  end
  
  #Function to pull this logic out of send_message and simplify it
  def submit_to_gateway!(post_args)
    # api key for twilio
    account_sid = 'ACc52800f150bf4cb5ac88d887129a9458'
    auth_token = '2faa2bb513de605158559d95d81d9b2d'

    # create the twilio REST client
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    #send SMS via post_args
    @client.account.sms.messages.create(
      post_args
    )
  end
  
  #Function to pull this logic out of send_message and simplify it
  def fake_submit_to_gateway!(post_args)
      Log4r::Logger['sms_logger'].info "Message attempt succeeded with api response \"Fake Message\"\n#{post_args.to_yaml}"
  end
  
  def persisted?
    false
  end
  
end