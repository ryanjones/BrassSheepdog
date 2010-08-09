class AddDeliveryTimeAndEnabledToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :delivery_time, :datetime
    add_column :service_subscriptions, :enabled, :boolean
  end

  def self.down
    remove_column :service_subscriptions, :enabled
    remove_column :service_subscriptions, :delivery_time
  end
end
