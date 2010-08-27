class RenameLastUpdateTimeToUpdateTimeInFieldStatuses < ActiveRecord::Migration
  def self.up
    rename_column :field_statuses, :last_update_time, :update_time
  end

  def self.down
    rename_column :field_statuses, :update_time, :last_update_time
  end
end
