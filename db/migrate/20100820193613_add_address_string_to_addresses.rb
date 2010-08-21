class AddAddressStringToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :address_string, :string
  end

  def self.down
    remove_column :addresses, :address_string
  end
end
