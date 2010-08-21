require "geo_ruby"
include Geokit::Geocoders
include GeoRuby::SimpleFeatures

class Address < ActiveRecord::Base
  
  attr_accessible :address_string

  def res
    @res or @res = MultiGeocoder.geocode(self.address_string)
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
    
    zone.zone + zone.day.to_s unless zone.nil?
  end
  
end
