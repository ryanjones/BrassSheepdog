class AddVerificationNoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :verification_no, :string
  end

  def self.down
    remove_column :users, :verification_no
  end
end
