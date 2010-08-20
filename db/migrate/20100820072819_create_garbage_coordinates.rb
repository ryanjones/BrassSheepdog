class CreateGarbageCoordinates < ActiveRecord::Migration
  def self.up
    create_table :garbage_coordinates do |t|
      t.float :x
      t.float :y

      t.timestamps
    end
  end

  def self.down
    drop_table :garbage_coordinates
  end
end
