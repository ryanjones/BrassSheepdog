class ElectionResult < ActiveRecord::Base
  belongs_to :election_candidate
  belongs_to :election_result_set
  
end
