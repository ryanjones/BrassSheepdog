class Service < ActiveRecord::Base
  has_many :service_subscriptions
end
