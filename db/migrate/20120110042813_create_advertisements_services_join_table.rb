class CreateAdvertisementsServicesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :advertisements_services, :id => false do |t|
      t.integer :service_id
      t.integer :advertisement_id
  end

  def self.down
     drop_table :advertisements_services
  end
  end
end
