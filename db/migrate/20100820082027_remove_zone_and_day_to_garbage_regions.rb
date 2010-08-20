class RemoveZoneAndDayToGarbageRegions < ActiveRecord::Migration
  def self.up
    remove_column :garbage_regions, :zone
    remove_column :garbage_regions, :day
  end

  def self.down
    add_column :garbage_regions, :day, :integer
    add_column :garbage_regions, :zone, :string
  end
end
