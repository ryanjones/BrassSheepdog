class AddEnabledToService < ActiveRecord::Migration
  def self.up
    add_column :services, :enabled, :boolean, :default => true
  end

  def self.down
    remove_column :services, :enabled
  end
end
