class AddAddressIdToGarbageSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :address_id, :integer
  end

  def self.down
    remove_column :service_subscriptions, :address_id
  end
end
