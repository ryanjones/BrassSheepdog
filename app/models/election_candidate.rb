class ElectionCandidate < ActiveRecord::Base
  has_many :election_result, :dependent => :destroy
  
end
