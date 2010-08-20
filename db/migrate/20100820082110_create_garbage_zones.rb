class CreateGarbageZones < ActiveRecord::Migration
  def self.up
    create_table :garbage_zones do |t|
      t.string :zone
      t.integer :day

      t.timestamps
    end
  end

  def self.down
    drop_table :garbage_zones
  end
end
