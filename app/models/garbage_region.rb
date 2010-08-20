require "geo_ruby"
include GeoRuby::SimpleFeatures

class GarbageRegion < ActiveRecord::Base
  has_many :garbage_coordinates
  
  def linear_ring
    point_array = Array.new
    self.garbage_coordinates.each do |coordinate|
      point_array.push coordinate.point
    end 
    
    LinearRing.from_points(point_array)
  end
end
