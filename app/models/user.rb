require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_many  :service_subscriptions, :dependent => :destroy
  has_many  :garbage_subscriptions, :dependent => :destroy
  
  has_many  :services, :through => :service_subscriptions
  
  before_validation :prepare_params

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  validates_presence_of     :phone_number
  validates_numericality_of :phone_number, :integer_only => true
  validates_length_of       :phone_number, :is => 10

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :phone_number



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  #########################################################
  #Subscription funtions
  def subscribe!(service)
    self.send(service.name.underscore + "_subscriptions").create(:service_id => service.id) 
  end
  
  def unsubscribe!(service)
    self.service_subscriptions.find_by_service_id(service).destroy
  end
  
  def subscribed?(service)
    !!service_subscriptions.find_by_service_id(service)
  end


  
  
  
  private
  
    def prepare_params
      self.phone_number = self.phone_number.gsub(/[^\d]/, '')
    end

  
end
