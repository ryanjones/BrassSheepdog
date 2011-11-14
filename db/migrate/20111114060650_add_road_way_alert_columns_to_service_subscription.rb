class AddRoadWayAlertColumnsToServiceSubscription < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :last_roadway_update_sent, :datetime
    add_column :service_subscriptions, :winter_parking_ban, :boolean, :default => false
    add_column :service_subscriptions, :residential_snow_maintenance, :boolean, :default => false
    add_column :service_subscriptions, :spring_street_cleaning, :boolean, :default => false
  end

  def self.down
    add_column :service_subscriptions, :last_roadway_update_sent
    add_column :service_subscriptions, :winter_parking_ban
    add_column :service_subscriptions, :residential_snow_maintenance
    add_column :service_subscriptions, :spring_street_cleaning
  end
end
