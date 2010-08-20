require "geo_ruby"
include Geokit::Geocoders
include GeoRuby::SimpleFeatures

class Address < Object
  
  #Moodified initialize to provide behavior closer to ActiveRecord::Base
  def initialize(attributes = nil)
    @address = attributes[:address] unless attributes.nil?
  end
  
  def address
    @address
  end
  
  def address=(string)
    @address=string
  end

  def res
    @res or @res = MultiGeocoder.geocode(@address)
  end
  
  def x
    self.res.lng
  end
  
  def y
    self.res.lat
  end
  
  def point
    @point or @point = Point.from_coordinates([self.x,self.y])
  end
  
  def formatted_zone
    zone = GarbageZone.find_address_zone(self)
    
    zone.zone + zone.day.to_s
  end
  
  #This model will always report being a new record
  def new_record?
    true
  end
end
