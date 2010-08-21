class AddManualZoneToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :manual_zone, :boolean
  end

  def self.down
    remove_column :service_subscriptions, :manual_zone
  end
end
