class AddServiceIdToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :service_id, :integer
  end

  def self.down
    remove_column :service_subscriptions, :service_id
  end
end
