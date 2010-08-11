class SmsMessage < Object
  require 'rexml/document'
  
  include Validatable
  attr_accessor :phone_number, :content
  
  validates_presence_of     :phone_number
  validates_numericality_of :phone_number, :only_integer => true
  validates_length_of       :phone_number, :is => 11, :message => "must be 11 digits"
  
  validates_length_of       :content, :maximum => 140
  validates_presence_of     :content
  

  

  #Moodified initialize to provide behavior closer to ActiveRecord::Base
  def initialize(attributes = nil)
    @phone_number = attributes[:phone_number] unless attributes.nil?
    @content = attributes[:content] unless attributes.nil?
  end
  
  #Sends the text message to our message provider
  def send_message
    #fail to send if the message doesn't pass validation
    return false if !self.valid?
    #otherwise continue to send the message
    require 'net/http'
    url = URI.parse('http://207.176.140.81:8088/garb/pybin.py/in_port')
    # build the params string
    post_args1 = { 'cellphone' => self.phone_number, 
                    'message_body' => self.content,
                    'api_key' => "lskjdf87fhyr6"}
    # send the request
    resp, data = Net::HTTP.post_form(url, post_args1)
    Rails.logger.debug(resp) if Rails.env.development?
    Rails.logger.debug(data) if Rails.env.development?
    if resp.kind_of?(Net::HTTPSuccess) 
      #report the returned message
      xml_object = REXML::Document.new(data)
      response_message = xml_object.elements['response'].text
      Log4r::Logger['sms_logger'].info "Message attempt succeeded with api response #{response_message}\n#{post_args1.to_yaml}"
      true
    else
      #report the failure
      Log4r::Logger['sms_logger'].info "Message attempt failed with http response #{resp}\n#{post_args1.to_yaml}"
      false
    end
  end
  
  #This model will always report being a new record
  def new_record?
    true
  end
end