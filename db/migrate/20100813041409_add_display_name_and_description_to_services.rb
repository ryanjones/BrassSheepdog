class AddDisplayNameAndDescriptionToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :display_name, :string
    add_column :services, :description, :string
  end

  def self.down
    remove_column :services, :description
    remove_column :services, :display_name
  end
end
