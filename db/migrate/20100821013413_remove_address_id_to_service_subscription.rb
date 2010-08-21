class RemoveAddressIdToServiceSubscription < ActiveRecord::Migration
  def self.up
    remove_column :service_subscriptions, :address_id
  end

  def self.down
    add_column :service_subscriptions, :address_id, :string
  end
end
