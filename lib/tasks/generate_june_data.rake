namespace :alertzy do
  desc "Populate June 2011 data"
  task :populate_june => :environment do
    generate_june_data
  end
end

def generate_june_data
  mondays = [6,13,20,27]
  tuesdays = [7,14,21,28]
  wednesdays = [1,8,15,22,29]
  thursdays = [2,9,16,23,30]
  fridays = [3,10,17,24]

  mondays.map! {|day| DateTime.parse("June #{day}, 2011 7:00:00")}
  tuesdays.map! {|day| DateTime.parse("June #{day}, 2011 7:00:00")}
  wednesdays.map! {|day| DateTime.parse("June #{day}, 2011 7:00:00")}
  thursdays.map! {|day| DateTime.parse("June #{day}, 2011 7:00:00")}
  fridays.map! {|day| DateTime.parse("June #{day}, 2011 7:00:00")}

  mondays.each do |date|
    [{:zone => "D", :day => 5},
     {:zone => "D", :day => 6},
     {:zone => "D", :day => 7}].each do |zone|
       GarbagePickup.create(:zone => zone[:zone], :day => zone[:day], :pickup_date => date)
    end
  end
  tuesdays.each do |date|
    [{:zone => "E", :day => 7},
     {:zone => "E", :day => 8}].each do |zone|
       GarbagePickup.create(:zone => zone[:zone], :day => zone[:day], :pickup_date => date)
    end
  end
  wednesdays.each do |date|
    [{:zone => "A", :day => 1},
     {:zone => "A", :day => 2}].each do |zone|
       GarbagePickup.create(:zone => zone[:zone], :day => zone[:day], :pickup_date => date)
    end
  end
  thursdays.each do |date|
    [{:zone => "B", :day => 2},
     {:zone => "B", :day => 3},
     {:zone => "B", :day => 4}].each do |zone|
       GarbagePickup.create(:zone => zone[:zone], :day => zone[:day], :pickup_date => date)
    end
  end
  fridays.each do |date|
    [{:zone => "C", :day => 4},
     {:zone => "C", :day => 5}].each do |zone|
       GarbagePickup.create(:zone => zone[:zone], :day => zone[:day], :pickup_date => date)
    end
  end
end
