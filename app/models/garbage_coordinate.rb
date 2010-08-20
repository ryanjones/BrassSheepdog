require "geo_ruby"
include GeoRuby::SimpleFeatures

class GarbageCoordinate < ActiveRecord::Base
  belongs_to :garbage_region
  
  def point
    @point or @point = Point.from_coordinates([self.x,self.y])
  end
end
