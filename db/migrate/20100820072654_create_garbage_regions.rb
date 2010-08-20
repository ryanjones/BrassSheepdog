class CreateGarbageRegions < ActiveRecord::Migration
  def self.up
    create_table :garbage_regions do |t|
      t.string :zone
      t.integer :day
      t.integer :id

      t.timestamps
    end
  end

  def self.down
    drop_table :garbage_regions
  end
end
