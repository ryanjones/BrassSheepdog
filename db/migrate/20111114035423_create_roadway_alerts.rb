class CreateRoadwayAlerts < ActiveRecord::Migration
  def self.up
    create_table :roadway_alerts do |t|
      t.string :atom_title
      t.datetime :atom_modified
      t.string :atom_id
      t.string :atom_email
      t.string :alert_type
      t.boolean :in_effect

      t.timestamps
    end
  end

  def self.down
    drop_table :roadway_alerts
  end
end
