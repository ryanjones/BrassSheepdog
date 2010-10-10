class CreateElectionResults < ActiveRecord::Migration
  def self.up
    create_table :election_results do |t|
      t.integer :election_candidate_id
      t.integer :election_result_set_id
      t.integer :votes

      t.timestamps
    end
  end

  def self.down
    drop_table :election_results
  end
end
