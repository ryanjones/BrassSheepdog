class AddBooleanDefaultsToFieldSubscriptionFields < ActiveRecord::Migration
  def self.up
    change_column :service_subscriptions, :update_about_northeast, :boolean, :default => true
    change_column :service_subscriptions, :update_about_northwest, :boolean, :default => true
    change_column :service_subscriptions, :update_about_southside, :boolean, :default => true
    change_column :service_subscriptions, :send_only_on_change, :boolean, :default => true
  end

  def self.down
    change_column :service_subscriptions, :update_about_northeast, :boolean
    change_column :service_subscriptions, :update_about_northwest, :boolean
    change_column :service_subscriptions, :update_about_southside, :boolean
    change_column :service_subscriptions, :send_only_on_change, :boolean
  end
end
