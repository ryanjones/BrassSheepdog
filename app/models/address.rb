require "geo_ruby"
include Geokit::Geocoders
include GeoRuby::SimpleFeatures

class Address < Object
  
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
end
