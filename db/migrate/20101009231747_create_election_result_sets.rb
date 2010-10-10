class CreateElectionResultSets < ActiveRecord::Migration
  def self.up
    create_table :election_result_sets do |t|
      t.integer :votes_cast
      t.integer :reporting
      t.integer :out_of

      t.timestamps
    end
  end

  def self.down
    drop_table :election_result_sets
  end
end
