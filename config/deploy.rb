require "bundler/capistrano"

set :application, "alertzy"
set :domain, "www.alertzy.com"
set :repository,  "git@github.com:RyanonRails/BrassSheepdog.git"

set :scm, :git
default_run_options[:pty] = true 
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/opt/apps/#{application}"
set :user, :deploy

role :web, "173.255.250.113:9223"                          # Your HTTP server, Apache/etc
role :app, "173.255.250.113:9223"                          # This may be the same as your `Web` server
role :db,  "173.255.250.113:9223", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

#If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:symlink"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  end
end

