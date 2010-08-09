class CreateGarbagePickups < ActiveRecord::Migration
  def self.up
    create_table :garbage_pickups do |t|
      t.string :entity_id
      t.datetime :pickup_date
      t.string :zone
      t.integer :day

      t.timestamps
    end
    add_index :garbage_pickups, [:zone, :day]
    add_index :garbage_pickups, :entity_id, :unique => true
  end

  def self.down
    drop_table :garbage_pickups
  end
end
