class GarbagePickup < ActiveRecord::Base
  
  validates_presence_of :pickup_date
  
  validates_presence_of :zone
  validates_length_of :zone, :is => 1
  validates_format_of :zone, :with => /^\w$/i
  
  validates_presence_of :day
  validates_length_of :day, :maximum => 100
  validates_numericality_of :day, :only_integer => true

  
end
