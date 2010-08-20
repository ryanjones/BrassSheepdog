class GarbageZone < ActiveRecord::Base
  has_many :garbage_regions
  
  def self.find_address_zone(address)
    
    zone = GarbageZone.all.detect do |current_zone|
      current_zone.contains_address address
    end
    
  end
  
  def contains_address(address)
    region = self.garbage_regions.detect do |current_region|
      current_region.contains_address address
    end
  end
end
