class UpdateGarbageZoneTable < ActiveRecord::Migration
  def self.up
    remove_column :garbage_zones, :zone
    remove_column :garbage_zones, :day
    add_column :garbage_zones, :day, :string
  end

  def self.down
  end
end
