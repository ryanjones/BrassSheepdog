class GarbagePickup < ActiveRecord::Base
  
  validates_presence_of :pickup_date
  
  validates_presence_of :zone
  validates_length_of :zone, :is => 1
  validates_format_of :zone, :with => /^\w$/i
  
  validates_presence_of :day
  validates_length_of :day, :maximum => 100
  validates_numericality_of :day, :only_integer => true
  
  # class function checks if there is a pickup today
  def self.pickup_on_day?(zone, day, date = DateTime.now.to_date)
    
    from_date = date
    to_date = 1.day.since(date)
    
    #return true if there is a pickup today, false if it's empty
    GarbagePickup.find(:all, 
                        :conditions => {:pickup_date => from_date..to_date, 
                                        :zone =>        zone,
                                        :day =>         day}).present?
  end
  
  def self.all_pickups_on_day(date = DateTime.now.to_date)
    from_date = date
    to_date = 1.day.since(from_date)
    GarbagePickup.find(:all, 
                        :conditions => {:pickup_date => from_date..to_date})
    
  end
  
  #method which finds the time of the next pickup for the given parameters
  def self.next_pickup(zone, day) 
    from_datetime = DateTime.now
    to_datetime = 1.year.since(from_datetime)
    GarbagePickup.find(:all, 
                        :conditions => {:pickup_date => from_datetime..to_datetime, 
                                        :zone =>        zone,
                                        :day =>         day}).first.pickup_date
  end
  

  
end
