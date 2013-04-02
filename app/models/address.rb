require "geo_ruby"
include Geokit::Geocoders
include GeoRuby::SimpleFeatures

class Address < ActiveRecord::Base
  
  attr_accessible :address_string

  def res
    @res or @res = Geocoder.coordinates(self.address_string)
  end
  
  def valid?
    !self.res.nil?
  end
  
  def x
    self.res[1] if self.valid?
  end
  
  def y
    self.res[0] if self.valid?
  end
  
  def point
    @point or @point = Point.from_coordinates([self.x,self.y]) if self.valid?
  end
  
  def formatted_zone
    zone = GarbageZone.find_address_zone(self)
    zone.day
  end
end
