class Service < ActiveRecord::Base
<<<<<<< HEAD
  has_many :service_subscriptions
  has_many :garbage_subscriptions
  has_many :field_status_subscriptions
=======
  has_many :service_subscriptions, :dependent => :destroy
  has_many :garbage_subscriptions, :dependent => :destroy
  has_many :field_status_subscriptions, :dependent => :destroy
>>>>>>> f91e25ea8f502dd1fb2e34ddb66859792 f968654
  
  validates_presence_of :name
  validates_presence_of :display_name
  validates_presence_of :description
  
  def subscription_name
    self.name.underscore + "_subscriptions"
  end
  
  def subscriptions
    #return the subscriptions for this service
    self.send(self.subscription_name)
  end
  
end
