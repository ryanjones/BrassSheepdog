class CreateElectionCandidates < ActiveRecord::Migration
  def self.up
    create_table :election_candidates do |t|
      t.string :row_key
      t.string :contest
      t.string :candidate_name

      t.timestamps
    end
  end

  def self.down
    drop_table :election_candidates
  end
end
