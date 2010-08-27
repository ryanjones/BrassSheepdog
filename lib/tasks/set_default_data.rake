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
    puts "Loading initial services"
    load_services
  end
end

def load_a_default_admin_user
  admin = User.create!(:login => "admin",
                       :email => "ben@zittlau.ca",
                       :password => "applesauce55",
                       :password_confirmation => "applesauce55",
                       :phone_number => "7809072969")
  admin.verified = true
  admin.admin = true
  admin.save
end

def load_services
  garbage = Service.create!(:name => "Garbage",
                       :display_name => "Garbage Pickup Notifications",
                       :description => "This service will provide you with helpful alerts to remind you to take out your garbage before pickups.  The notification timing is customizable.")
  field_subscription = Service.create!(:name => "FieldStatus",
                       :display_name => "Sports Field Status Updates",
                       :description => "This service will send you updates whenever the statuses of sports fields published by the City of Edmonton.  You can select which areas of Edmonton you would like updates for.")                     
end