require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_many  :service_subscriptions, :dependent => :destroy
  has_many  :garbage_subscriptions, :dependent => :destroy
  
  has_many  :services, :through => :service_subscriptions
  
  before_validation :prepare_params
  
  before_update :reset_verification_if_required
  before_update :require_old_password
  
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
  validates_length_of       :phone_number, :is => 11
  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :phone_number, :old_password



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
  #Subscription functions
  def subscribe(service, params = Hash.new)
    #service enabled has a default of false (incase the browser is closed when subscribing)
    params[:service_id] ||= service.id
    self.subscribed?(service) || self.send(service.subscription_name).create(params)
  end
  
  
  def unsubscribe(service)
    self.service_subscriptions.find_by_service_id(service).destroy
  end
  
  def subscribed?(service)
    service_subscriptions.find_by_service_id(service)
  end
  
  def verified?
      self.verified == true
  end
  
  #disable all the users alerts
  def disable_all_alerts
    self.service_subscriptions.each do |subscription|
      subscription.update_attribute :enabled, false
    end
  end

  #enable all the users alerts
  def enable_all_alerts
    self.service_subscriptions.each do |subscription|
      subscription.update_attribute :enabled, false
    end
  end
  
  # Send verification no to logged in user
  def send_verification_no
    random_number = (89999 * rand + 100000).to_int
    self.verification_no = random_number
    self.save    # Random verification no saved to db
    sms = SmsMessage.new(:phone_number => self.phone_number,
                         :content      => 'Alertzy verification number: ' + self.verification_no.to_s)
    sms.send_message! # Send out verification text to users phone
  end
  
  ##################################################
  #### Methods for old password virtual attribute ##
  ##################################################
  def old_password
    @old_password
  end
  
  def old_password=(password)
    @old_password = password
  end

  ##################################################
  #### A currently fake method for the users timezone ##
  ##################################################
  def time_zone
    "Mountain Time (US & Canada)"
  end
  
  
  private
    def require_old_password
      if self.crypted_password_change
        unless self.crypted_password_was == encrypt(@old_password)
          errors.add_to_base("Your old password must be correct to change your password.")
          false
        end
      end
    end
  
    def prepare_params
      self.phone_number = self.phone_number.gsub(/[^\d]/, '')
    end
    
    def reset_verification_if_required
      if self.phone_number_change
        self.update_attribute :verified, false
        self.send_verification_no
      end
    end
end
