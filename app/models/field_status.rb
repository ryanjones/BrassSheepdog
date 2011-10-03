require 'open-uri'
class FieldStatus < ActiveRecord::Base
  def self.update
    southside_rss = SimpleRSS.parse open('http://coewebapps.edmonton.ca/external/facilitynotifications/rss/SouthsideSportsFields.rss')
    northeast_rss = SimpleRSS.parse open('http://coewebapps.edmonton.ca/external/facilitynotifications/rss/NortheastSportsFields.rss')
    northwest_rss = SimpleRSS.parse open('http://coewebapps.edmonton.ca/external/facilitynotifications/rss/NorthwestSportsFields.rss')
    update_times = [southside_rss.items.first.pubDate.to_datetime, northeast_rss.items.first.pubDate.to_datetime, northwest_rss.items.first.pubDate.to_datetime]
    latest_update_time = update_times.max
    if (latest_update_time != self.last_update_time) 
      newupdate = Hash.new
      newupdate[:northeast_open] = (northeast_rss.items.first.description.gsub(/^.*Status: (Open|Closed).*$/im, '\\1')  == 'Open')
      newupdate[:northwest_open] = (northwest_rss.items.first.description.gsub(/^.*Status: (Open|Closed).*$/im, '\\1')  == 'Open')
      newupdate[:south_open] = (southside_rss.items.first.description.gsub(/^.*Status: (Open|Closed).*$/im, '\\1')  == 'Open')
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
