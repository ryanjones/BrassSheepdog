class AddVerificationTryToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :verification_try, :date
  end

  def self.down
    remove_column :users, :verification_try
  end
end
