require 'deprec'
  
set :application, "Alertzy"
set :domain, "www.alertzy.com"
set :repository,  "git@github.com:ryanjones1234/BrassSheepdog.git"

#added by me to get things working [bzittlau]
set :user, 'deploy'
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true
set :mongrel_rails, "/opt/ruby-enterprise-1.8.6-20090610/bin/mongrel_rails"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
   
set :ruby_vm_type,      :ree        # :ree, :mri
set :web_server_type,   :apache     # :apache, :nginx
set :app_server_type,   :mongrel  # :passenger, :mongrel
set :db_server_type,    :mysql      # :mysql, :postgresql, :sqlite

# set :packages_for_project, %w(libmagick9-dev imagemagick libfreeimage3) # list of packages to be installed
# set :gems_for_project, %w(rmagick mini_magick image_science) # list of gems to be installed

# Update these if you're not running everything on one host.
role :app, domain
role :web, domain
role :db,  domain, :primary => true, :no_release => true

# If you aren't deploying to /opt/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/opt/apps/#{application}"

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    top.deprec.app.restart
  end
end