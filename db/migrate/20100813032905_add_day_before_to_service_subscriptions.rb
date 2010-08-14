class AddDayBeforeToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :day_before, :boolean, :default => true
  end

  def self.down
    remove_column :service_subscriptions, :day_before
  end
end
