class SubscriptionAddressRelation < ActiveRecord::Base
  belongs_to :garbage_subscription
  belongs_to :address
end
