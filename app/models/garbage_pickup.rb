class GarbagePickup < ActiveRecord::Base
  
  validates_presence_of :pickup_date
  
  validates_presence_of :zone
  validates_length_of :zone, :is => 1
  validates_format_of :zone, :with => /^\w$/i
  
  validates_presence_of :day
  validates_length_of :day, :maximum => 100
  validates_numericality_of :day, :only_integer => true
  
  # class function checks if there is a pickup today
  def self.pickup_today?(date = DateTime.now.to_date) {
    
    
    #return true if there is a pickup today, false if it's empty
    GarbagePickup.find(:all, 
                        :conditions => {:pickup_date => from_date..to_date, 
                                        :zone =>        self.zone,
                                        :day =>       self.day}).present?
  }

  
end
