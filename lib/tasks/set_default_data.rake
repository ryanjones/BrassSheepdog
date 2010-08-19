namespace :db do
  desc "Populate the database with the default data"
  task :populate => :environment do
    puts "Resetting the database"
    Rake::Task['db:reset'].invoke
    Rake::Task['db:get_garbage_schedule'].invoke
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
                       :phone_number => "17807102820")
  admin.verified = true
  admin.admin = true
  admin.save
end

def load_services
  garbage = Service.create!(:name => "Garbage",
                       :display_name => "Garbage Pickup Notifications",
                       :description => "This service will provide you with helpful alerts to remind you to take out your garbage before pickups.  The notification timing is customizable")
end