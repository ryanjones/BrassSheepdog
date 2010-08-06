class SmsMessage < Object
  include Validatable
  attr_accessor :phone_number, :content
  
  validates_presence_of     :phone_number
  validates_numericality_of :phone_number, :only_integer => true
  validates_length_of       :phone_number, :is => 10, :message => "must be 10 digits"
  
  validates_length_of       :content, :maximum => 140
  validates_presence_of     :content
  

  def initialize(attributes = nil)
    @phone_number = attributes[:phone_number] unless attributes.nil?
    @content = attributes[:content] unless attributes.nil?
  end
  
  def send_message
    require 'net/http'
    url = URI.parse('http://207.176.140.81:8088/garb/pybin.py/in')
    # build the params string
    post_args1 = { 'cellphone' => self.phone_number, 'message_body' => self.content }
    # send the request
    resp, data = Net::HTTP.post_form(url, post_args1)
    Rails.logger.debug(resp) if Rails.env.development?
    Rails.logger.debug(data) if Rails.env.development?
    true
  end
  
  def new_record?
    true
  end
end