class AddZoneAndDayToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :zone, :string
    add_column :service_subscriptions, :day, :integer
  end

  def self.down
    remove_column :service_subscriptions, :day
    remove_column :service_subscriptions, :zone
  end
end
