# All this class does is update the roadway alert table (when a new one is found in atom)
class RoadwayAlert < ActiveRecord::Base
  def self.update
    # Get gmail atom feed
    gmail_rss = NotificationEmail.get_gmail_atom
    
    # Get all of the existing Roadway Alerts
    all_roadway_alerts = RoadwayAlert.all

    # Check to see if there's any new alerts for the Seasonal Parking Ban, if so, add to db
    gmail_rss.items.each do |rss|
      # TODO add parking ban over subject check, set in_effect to false. Need a full cycle before we can release
      
      if rss.title =~ /Parking Ban Declared/
        # Regex email out of author
        rss_email_array = rss.author.split(/\n/)
        rss_email = rss_email_array[1]
        
        # Make sure it's coming from the road alerts email
        if rss.author =~ /#{rss_email}/

          # Check if we have any alerts in our db
          if all_roadway_alerts.count == 0
            # We'll only come into here on our first run through
            # Add any existing parking bans
              RoadwayAlert.create!({:atom_title => rss.title,
                                    :atom_modified => rss.modified,
                                    :atom_id => rss.id,
                                    :atom_email => rss_email,
                                    :alert_type => 'Seasonal Parking Ban',
                                    :in_effect => true})      
          else
            # Check if Alert exists in the DB (dont wanna hit the db each time, so I'll cycle through this array)
            all_roadway_alerts.each do |alert|
              found = false

              # Check to see if a pair is found
              if alert.atom_id == rss.id 
                # the id has been found! found is true
                found = true
              end
              
              # Add the item to the DB if it's not found
              if found == false
                RoadwayAlert.create!({:atom_title => rss.title,
                                      :atom_modified => rss.modified,
                                      :atom_id => rss.id,
                                      :atom_email => rss_email,
                                      :alert_type => 'Seasonal Parking Ban',
                                      :in_effect => true })      
              end
            end # each roadway end  
          end # roadway count end   
        end # rss author end
      end # rss title end
      
      
      if rss.title =~ /Residential Bus Route Parking Ban Ends/
        # Regex email out of author
        rss_email_array = rss.author.split(/\n/)
        rss_email = rss_email_array[1]
        
        # Make sure it's coming from the road alerts email
        if rss.author =~ /#{rss_email}/

          # Check if we have any alerts in our db
          if all_roadway_alerts.count == 0
            # We'll only come into here on our first run through
            # Add any existing parking bans
              RoadwayAlert.create!({:atom_title => rss.title,
                                    :atom_modified => rss.modified,
                                    :atom_id => rss.id,
                                    :atom_email => rss_email,
                                    :alert_type => 'Seasonal Parking Ban',
                                    :in_effect => false})      
          else
            # Check if Alert exists in the DB (dont wanna hit the db each time, so I'll cycle through this array)
            all_roadway_alerts.each do |alert|
              found = false

              # Check to see if a pair is found
              if alert.atom_id == rss.id 
                # the id has been found! found is true
                found = true
              end
              
              # Add the item to the DB if it's not found
              if found == false
                RoadwayAlert.create!({:atom_title => rss.title,
                                      :atom_modified => rss.modified,
                                      :atom_id => rss.id,
                                      :atom_email => rss_email,
                                      :alert_type => 'Seasonal Parking Ban',
                                      :in_effect => false })      
              end
            end # each roadway end  
          end # roadway count end   
        end # rss author end
      end # rss title end
    end #rss do end
  end #update end  
     
      
  # Could potentially add the following, but they seem kinda useless. I DID NOT code the subscription (messages, methods etc.) to support these
  # as I feel they're a waste of time and add unnessecary complexity
     # Residential Snow Maintenance Alert 
     # Spring Street Cleaning Alert

end
