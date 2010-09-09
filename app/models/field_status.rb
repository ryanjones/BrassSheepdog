require 'open-uri'
class FieldStatus < ActiveRecord::Base
  def self.update
    rss = SimpleRSS.parse open('http://coewebapps.edmonton.ca/external/communityservices/rss/sportsfieldstatus.rss')
    latest_update_time = rss.items.first.pubDate.to_datetime
    if (latest_update_time != self.last_update_time) 
      description = rss.items.first.description
      newupdate = Hash.new
      newupdate[:northeast_open] = (description.gsub(/^.*Northeast fields are (open|closed).*$/im, '\\1')  == 'open')
      newupdate[:northwest_open] = (description.gsub(/^.*Northwest fields are (open|closed).*$/im, '\\1')  == 'open')
      newupdate[:south_open] = (description.gsub(/^.*Southside fields are (open|closed).*$/im, '\\1')  == 'open')
      newupdate[:update_time] = latest_update_time
    
      FieldStatus.create!(newupdate)
    end
  end
  
  def self.last_update_time 
    latest_update = self.latest_update
    latest_update.update_time if latest_update
  end 
  
  def self.latest_update
    FieldStatus.find(:first, :order => "update_time DESC")
  end
    
end
