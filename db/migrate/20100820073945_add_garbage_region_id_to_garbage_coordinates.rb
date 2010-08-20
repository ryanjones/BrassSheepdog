class AddGarbageRegionIdToGarbageCoordinates < ActiveRecord::Migration
  def self.up
    add_column :garbage_coordinates, :garbage_region_id, :integer
  end

  def self.down
    remove_column :garbage_coordinates, :garbage_region_id
  end
end
