class CityElectionSubscription < ServiceSubscription

  HUMANIZED_ATTRIBUTES = {

    }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  #being used for method to over-ride the service
  alias_method :original_service, :service
  
  #hardcode the service
  def service_id
    self[:service_id] or self.service.id
  end
  
  #hardcode the service if not set
  def service
      self.original_service or Service.find_by_name("CityElection")
  end
  
  #define the message which will get sent to the uer
  def alert_content
    message = String.new
    #get the latest result set
    latest_result_set = ElectionResultSet.latest
    
    #get results and sort by number of votes
    results = latest_result_set.election_result.all
    results.sort! { |a, b|  b.votes <=> a.votes }
    
    results = results.first(3)
    
    #for each candidates result create an entry
    results.each do |election_result|
      current_candidate_name = election_result.election_candidate.candidate_name
      vote_string = election_result.votes.to_s.rjust(8)
      
      message += vote_string + " " + current_candidate_name + "\n"
    end
    #suggest that there are more results not displayed
    message += "...\n"
    
    #add a footer to the message
    message += "\nReporting: #{latest_result_set.reporting}/#{latest_result_set.out_of}"
    
    
  end
  
  #define the subject line for alerts sent to the user
  def alert_subject
    "Edmonton City Election Update!"
  end
  
  def next_alert_time
    "During vote counting Oct.18th"
  end

  
  #method to determine whether an alert should be sent to the subscribed user
  def alert_user?
    # check the three necessary conditions
    # in order of increasing cost
    
    #uncomment when the real data is available
    self.enabled? && are_there_new_votes?
  end
  
  def update_previous_values
    self.previous_votes_cast = ElectionResultSet.latest_votes_cast
    self.save
  end
  
  private 
    def are_there_new_votes?
      
      #check if there are any new votes since the last update sent to the user
      update_user = ElectionResultSet.latest_votes_cast != self.previous_votes_cast
      
      #update the value recorded in the subscription
      update_previous_values
      
      return update_user
    end
  
end
