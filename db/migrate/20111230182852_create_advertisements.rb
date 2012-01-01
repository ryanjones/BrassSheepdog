class CreateAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :advertisements do |t|
      t.string :name
      t.string :company
      t.boolean :enabled
      t.integer :credits
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :advertisements
  end
end
