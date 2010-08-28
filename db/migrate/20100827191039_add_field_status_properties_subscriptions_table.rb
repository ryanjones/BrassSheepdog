class AddUpdateAboutNortheastAndUpdateAboutNorthwestAndUpdateAboutSouthsideAndSendOnlyOnChangeAndPreviousNortheastStateAndPreviousNorthwestStateAndPreviousSouthsideStateToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :update_about_northeast, :boolean
    add_column :service_subscriptions, :update_about_northwest, :boolean
    add_column :service_subscriptions, :update_about_southside, :boolean
    add_column :service_subscriptions, :send_only_on_change, :boolean
    add_column :service_subscriptions, :previous_northeast_state, :boolean
    add_column :service_subscriptions, :previous_northwest_state, :boolean
    add_column :service_subscriptions, :previous_southside_state, :boolean
  end

  def self.down
    remove_column :service_subscriptions, :previous_southside_state
    remove_column :service_subscriptions, :previous_northwest_state
    remove_column :service_subscriptions, :previous_northeast_state
    remove_column :service_subscriptions, :send_only_on_change
    remove_column :service_subscriptions, :update_about_southside
    remove_column :service_subscriptions, :update_about_northwest
    remove_column :service_subscriptions, :update_about_northeast
  end
end
