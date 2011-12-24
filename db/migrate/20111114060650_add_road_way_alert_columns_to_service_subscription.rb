class AddRoadWayAlertColumnsToServiceSubscription < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :last_roadway_update_sent, :datetime
    add_column :service_subscriptions, :winter_parking_ban, :boolean, :default => false
  end

  def self.down
    remove_column :service_subscriptions, :last_roadway_update_sent
    remove_column :service_subscriptions, :winter_parking_ban
  end
end
