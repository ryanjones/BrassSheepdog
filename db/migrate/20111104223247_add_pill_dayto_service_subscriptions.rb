class AddPillDaytoServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :pill_day, :integer, :default => 0
  end

  def self.down
    remove_column :service_subscriptions, :pill_day
  end
end
