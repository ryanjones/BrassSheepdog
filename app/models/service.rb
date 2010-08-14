class Service < ActiveRecord::Base
  has_many :service_subscriptions
  
  validates_presence_of :name
  validates_presence_of :display_name
  validates_presence_of :description
end
