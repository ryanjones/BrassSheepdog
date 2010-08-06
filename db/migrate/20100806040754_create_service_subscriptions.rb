class CreateServiceSubscriptions < ActiveRecord::Migration
  def self.up
      create_table :service_subscriptions do |t|
      t.string :name
      t.string :type
      
      t.timestamps
    end
  end

  def self.down
    drop_table :service_subscriptions
  end
end
