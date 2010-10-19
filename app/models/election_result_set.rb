require 'ruby_odata'
class ElectionResultSet < ActiveRecord::Base
  has_many :election_result, :dependent => :destroy
  
  def self.update
    #use ruby odata to fetch the data from the api
    svc = OData::Service.new "http://datafeed.edmonton.ca/v1/coe/"
    #get the election results so far
    svc.Election2010Results
    election_results = svc.execute
    
    #create a new set with only mayoral candidates
    mayoral_election_results = Array.new
    election_results.each do |election_result|
      if election_result.contest == "Mayor"
        mayoral_election_results << election_result
      end
    end
    
    #check if new votes have been cast
    unless mayoral_election_results.first.votescast == ElectionResultSet.latest_votes_cast
      
      #if there are new votes, create a new result set
      params = Hash.new
      params[:votes_cast] = mayoral_election_results.first.votescast
      params[:reporting] = mayoral_election_results.first.reporting
      params[:out_of] = mayoral_election_results.first.outof
      election_result_set = ElectionResultSet.create!(params)
      
      mayoral_election_results.each do |election_result|
        #get the candidates object
        candidate = ElectionCandidate.find_by_candidate_name(election_result.candidatename)
        #create the candidate if they don't already exist
        unless candidate
          params = Hash.new
          params[:row_key] = election_result.RowKey
          params[:candidate_name] = election_result.candidatename
          params[:contest] = election_result.contest
          candidate = ElectionCandidate.create!(params)
        end
        
        #create the new election result
        newresult = Hash.new
        newresult[:election_result_set] = election_result_set
        newresult[:election_candidate] = candidate
        newresult[:votes] = election_result.votes
        ElectionResult.create!(newresult)
        
      end
    end
  end
  
  def self.latest_votes_cast 
    latest_set = self.latest
    latest_set.votes_cast if latest_set
  end 
  
  def self.latest
    ElectionResultSet.find(:first, :order => "updated_at DESC")
  end
end
