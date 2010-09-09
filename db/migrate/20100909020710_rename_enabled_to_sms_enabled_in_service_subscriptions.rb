class RenameEnabledToSmsEnabledInServiceSubscriptions < ActiveRecord::Migration
  def self.up
    rename_column :service_subscriptions, :enabled, :sms_enabled
    add_column :service_subscriptions, :email_enabled, :boolean, :default => true
    ServiceSubscription.reset_column_information
    ServiceSubscription.all.each do |s|
      s.update_attribute :email_enabled, false
    end
  end

  def self.down
    rename_column :service_subscriptions, :sms_enabled, :enabled
    remove_column :service_subscriptions, :email_enabled
  end
end