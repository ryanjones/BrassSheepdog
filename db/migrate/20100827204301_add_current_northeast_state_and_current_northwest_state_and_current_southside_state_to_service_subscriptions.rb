class AddCurrentNortheastStateAndCurrentNorthwestStateAndCurrentSouthsideStateToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :current_northeast_state, :boolean
    add_column :service_subscriptions, :current_northwest_state, :boolean
    add_column :service_subscriptions, :current_southside_state, :boolean
  end

  def self.down
    remove_column :service_subscriptions, :current_southside_state
    remove_column :service_subscriptions, :current_northwest_state
    remove_column :service_subscriptions, :current_northeast_state
  end
end
