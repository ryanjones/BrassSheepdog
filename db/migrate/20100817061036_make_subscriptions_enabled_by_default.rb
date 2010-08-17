class MakeSubscriptionsEnabledByDefault < ActiveRecord::Migration
  def self.up
    change_column :service_subscriptions, :enabled, :boolean, :default => true
  end

  def self.down
    change_column :service_subscriptions, :enabled, :boolean
  end
end
