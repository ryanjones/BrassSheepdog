# All this class does is update the roadway alert table (when a new one is found in atom)
class RoadwayAlert < ActiveRecord::Base
  def self.update
    # Get gmail atom feed
    gmail_rss = NotificationEmail.get_gmail_atom
    
    # Get all of the existing Roadway Alerts
    all_roadway_alerts = RoadwayAlerts.all
    
    # Check to see if there's any new alerts, if so, add to db
    rss.items.each do |i|
      
      # if  .match regex Winter Parking Ban Alert (atom_title)
        # Check gmail atom id vs Roadway Alert atom id
        # If it's a new id (no match), add it to the DB
      
      
      # if  .match regex Residential Snow Maintenance Alert (atom_title)
        # Check gmail atom id vs Roadway Alert atom id
        # If it's a new id (no match), add it to the DB
      
      # if  .match regex Spring Street Cleaning Alert (atom_title)
        # Check gmail atom id vs Roadway Alert atom id
        # If it's a new id (no match), add it to the DB
      
    end
  end
  
end
