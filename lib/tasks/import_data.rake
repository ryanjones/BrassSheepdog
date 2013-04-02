require 'ruby_odata'
require 'pry'

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
    sql = File.open("script/dbdata/garbage_only_data_mysql.sql").read
    sql.split(';').each do |sql_statement|
      ActiveRecord::Base.connection.execute(sql_statement)
    end
  end
end

#will fetch the garabe pickup data from the city data catalogue api
def load_pickup_data_from_city
  #use ruby odata to feth the data from the api
  puts "Creating API connection"
  uri = URI.parse("http://data.edmonton.ca/api/views/uqbx-yqac/rows.json")
  #get the garbage schedule collection
  puts "Fetching data from api"
  response = Net::HTTP.get_response(uri)
  data = ActiveSupport::JSON.decode(response.body)["data"]
  
  puts "Adding data to database"
  data.each do |pickup_event|
    begin
      params = Hash.new
      params[:entity_id] = pickup_event[1]
      params[:zone] = pickup_event[8].gsub(/Zone (\w)/i, '\\1')
      params[:day] = pickup_event[9].gsub(/Day (\d)/i, '\\1')
      params[:pickup_date] = Date.strptime(pickup_event[10], '%m/%d/%Y').to_datetime

      #shim the time to noon to avoid weird date shifting effects
      params[:pickup_date] = 12.hours.since(params[:pickup_date])
      
      #create the entry
      GarbagePickup.create!(params)
    rescue
      debugger
      p nil
    end
  end
end

#will fetch the garabe pickup data from the city data catalogue api

def load_zone_data_from_city
  #use ruby odata to feth the data from the api
  puts "Fetch KML file"
  url = "http://data.edmonton.ca/api/geospatial/edex-dz5d?method=export&format=KML"
  data = Net::HTTP.get URI.parse(url)
  
  puts "Creating xml_object from data"
  xml_object = REXML::Document.new data
  
  zones = xml_object.elements.to_a('//Placemark')
  
  puts "Adding zones to database"
  zones.each do |zone|
    day = zone.elements["description"].text.match(/atr-value">(\w*)</)[1]
    
    garbage_zone = GarbageZone.find_or_create_by_day(day)
    
    zone.get_elements(".//LinearRing/coordinates").each do |region|
      garbage_region = garbage_zone.garbage_regions.create!
      coordinates = region.text.split(" ")
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
        
