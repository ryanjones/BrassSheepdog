class RemoveNameToUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :name
  end

  def self.down
    add_column :name, :string, :limit => 100, :default => '', :null => true
  end
end
