class AddUserIdToServiceSubscription < ActiveRecord::Migration
  def self.up
  	  	    add_column :service_subscriptions, :user_id, :integer
  end

  def self.down
  	  	    remove_column :service_subscriptions, :user_id
  end
end
