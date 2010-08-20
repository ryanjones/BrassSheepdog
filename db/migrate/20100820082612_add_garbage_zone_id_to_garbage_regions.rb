class AddGarbageZoneIdToGarbageRegions < ActiveRecord::Migration
  def self.up
    add_column :garbage_regions, :garbage_zone_id, :integer
  end

  def self.down
    remove_column :garbage_regions, :garbage_zone_id
  end
end
