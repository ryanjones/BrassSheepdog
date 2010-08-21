class AddAddressToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :address, :string
  end

  def self.down
    remove_column :service_subscriptions, :address
  end
end
