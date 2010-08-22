require 'ruby_odata'

namespace :db do
  desc "Fetch garbage delivery times"
  task :get_garbage_schedule => :environment do
    GarbagePickup.delete_all
    load_pickup_data_from_city
  end

  desc "Fetch garbage zones"
  task :get_garbage_zones => :environment do
    puts "Deleting existing zone data"
    GarbageZone.delete_all
    GarbageRegion.delete_all
    GarbageCoordinate.delete_all
    load_zone_data_from_city
  end
  
  
  task :import_garbage_data_from_sql => :environment do
    sql = File.open("script/dbdata/garbage_only_data.sql").read
    sql.split(';').each do |sql_statement|
      ActiveRecord::Base.connection.execute(sql_statement)
    end
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

#will fetch the garabe pickup data from the city data catalogue api
def load_zone_data_from_city
  #use ruby odata to feth the data from the api
  puts "Fetch KML file"
  url = "http://datafeed.edmonton.ca/v1/coe/GarbageCollectionZones/?$filter=&format=kml"
  data = Net::HTTP.get URI.parse(url)
  
  puts "Creating xml_object from data"
  xml_object = REXML::Document.new data
  
  regions = xml_object.elements.to_a('//Placemark')
  
  puts "Adding zones to database"
  regions.each do |region|
    params = Hash.new
    params[:zone] = region.elements[".//SimpleData[@name='ZONE']"].text.gsub(/Zone (\w)/i, '\\1')
    params[:id] = region.elements[".//SimpleData[@name='ID']"].text.gsub(/ID (\d+)/i, '\\1')
    params[:day] = region.elements[".//SimpleData[@name='DAY']"].text.gsub(/Day (\d)/i, '\\1')
    
    garbage_zone = GarbageZone.find_by_day_and_zone(params[:day], params[:zone])
    
    if garbage_zone.nil?
      garbage_zone = GarbageZone.create!(:day => params[:day], :zone => params[:zone])
    end
    
    garbage_region = garbage_zone.garbage_regions.create!(:id => params[:id])
    
    coordinates_element = region.elements[".//coordinates"]

    puts "Adding coordinates to region"
    if coordinates_element
      coordinates = coordinates_element.text.split(" ")
      coordinates.each do |coordinate|
        coordinate_array = coordinate.split(",")
        x_coordinate = coordinate_array[0]
        y_coordinate = coordinate_array[1]
        coord = Hash.new
        coord[:x] = x_coordinate
        coord[:y] = y_coordinate
        garbage_region.garbage_coordinates.create!(coord)
      end
    end
    
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
        
