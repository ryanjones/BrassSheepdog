class AddPillDaytoServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :pill_day, :integer, :default => 0
    add_column :service_subscriptions, :pill_delivery_time, :datetime
    add_column :service_subscriptions, :pill_length, :integer, :default => 0
  end

  def self.down
    remove_column :service_subscriptions, :pill_day
    remove_column :service_subscriptions, :pill_delivery_time
    remove_column :service_subscriptions, :pill_length
  end
end
