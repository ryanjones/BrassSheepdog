class AddServiceIdToAdvertisements < ActiveRecord::Migration
  def self.up
    add_column :advertisements, :service_id, :integer
  end

  def self.down
    remove_column :advertisements, :service_id
  end
end
