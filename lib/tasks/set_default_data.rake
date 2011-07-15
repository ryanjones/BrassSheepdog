namespace :db do
  desc "Populate the database with the default data"
  task :populate => :environment do
    puts "Resetting the database"
    Rake::Task['db:reset'].invoke
    #Rake::Task['db:get_garbage_schedule'].invoke
    #Rake::Task['db:get_garbage_zones'].invoke
    puts "Import garbage data from packaged sql file"
    Rake::Task['db:import_garbage_data_from_sql'].invoke
    Rake::Task['db:populate_without_garbage'].invoke
  end
  
  task :populate_without_garbage => :environment do

    puts "Loading a default admin user"
    load_a_default_admin_user
    Rake::Task['db:load_services'].invoke
  end
  
  task :load_services => :environment do

    puts "Loading initial services"
    load_services
  end
end

def load_a_default_admin_user
  unless User.find_by_login("admin")
    admin = User.create!(:login => "admin",
                         :email => "ben@zittlau.ca",
                         :password => "applesauce55",
                         :password_confirmation => "applesauce55",
                         :phone_number => "5556667777")
    admin.verified = true
    admin.admin = true
    admin.save
  end
end

def load_services
  unless Service.find_by_name("Garbage")

    garbage = Service.create!(
                       :name => "Garbage",
                       :display_name => "Garbage Pickup Notifications",
                       :description => "This service will provide you with helpful alerts to remind you to take out your garbage before pickups.  The notification timing is customizable.",
                       :enabled => true)
  end
  unless Service.find_by_name("FieldStatus")
    field_status = Service.create!(
                       :name => "FieldStatus",
                       :display_name => "Sports Field Closure Updates",
                       :description => "This service will send you updates whenever the City of Edmonton open or closes fields.  You can select which areas of Edmonton you would like updates for.",
                       :enabled => true)                     
  end
  unless Service.find_by_name("CityElection")
    election_service = Service.create!(
                       :name => "CityElection",
                       :display_name => "City Election Live Updates",
                       :description => "This service will send you live updates as the votes are tallied in the City of Edmonton's Mayoral election occuring on October 18th, 2010.",
                       :enabled => false)                     
  end
end