class CreateFieldStatuses < ActiveRecord::Migration
  def self.up
    create_table :field_statuses do |t|
      t.boolean :northeast_open
      t.boolean :northwest_open
      t.boolean :south_open
      t.datetime :last_update_time

      t.timestamps
    end
  end

  def self.down
    drop_table :field_statuses
  end
end
