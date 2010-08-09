require 'ruby_odata'

namespace :db do
  desc "Fetch garbage delivery times"
  task :get_garbage_schedule => :environment do
    GarbagePickup.delete_all
    load_pickup_data_from_city
  end
end

#will fetch the garabe pickup data from the city data catalogue api
def load_pickup_data_from_city
  #use ruby odata to feth the data from the api
  puts "Creating OData connection"
  svc = OData::Service.new "http://datafeed.edmonton.ca/v1/coe/"
  #get the garbage schedule collection
  svc.GarbageCollectionSchedule
  puts "Fetching data from api"
  pickup_events = svc.execute
  
  puts "Adding data to database"
  pickup_events.each do |pickup_event|
    params = Hash.new
    params[:entity_id] = pickup_event.entityid
    params[:zone] = pickup_event.zone.gsub(/Zone (\w)/i, '\\1')
    params[:day] = pickup_event.day.gsub(/Day (\d)/i, '\\1')
    params[:pickup_date] = pickup_event.pickup_date
    
    #create the entry
    GarbagePickup.create!(params)
  end
end

#this is no longer needed as the zone's have been fixed in the source data
# def remap_zone(mismapped_zone)
#   # array to remap this mis-mapped city data
#   map_array = {"13" => "8", "12" => "7", "11" => "7", "10" => "6", "9" => "5", "8" => "5", "7" => "4", "6" => "4",
#               "5" => "3", "4" => "2", "3" => "2", "2" => "1"}
#   # return the correct zone
#   map_array[mismapped_zone]
# end
        
