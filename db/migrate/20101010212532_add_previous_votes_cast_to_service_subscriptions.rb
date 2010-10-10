class AddPreviousVotesCastToServiceSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :service_subscriptions, :previous_votes_cast, :integer, :default => 0
  end

  def self.down
    remove_column :service_subscriptions, :previous_votes_cast
  end
end
