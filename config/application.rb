require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Alertzy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    #
    ## set delivery method to :smtp, :sendmail or :test
    config.action_mailer.delivery_method = :smtp
  
    # these options are only needed if you choose smtp delivery
    # config.action_mailer.smtp_settings = {
    #    :address        => 'www.alertzy.com',
    #    :port           => 26,
    #    :domain         => 'alertzy.com',
    #    :authentication => :login,
    #    :user_name      => 'updates@alertzy.com',
    #    :password       => 'applesauce55'
    #  }
    
    config.action_mailer.smtp_settings = {
      :enable_starttls_auto => true,
      :address => "smtp.gmail.com",
      :port => 587,
      :domain => "alertzy.com",
      :authentication => :plain,
      :user_name => "updates@alertzy.com",
      :password => "applesauce55",
      :openssl_verify_mode  => OpenSSL::SSL::VERIFY_NONE
    }
    
   config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    #config.action_view.javascript_expansions[:defaults] = %w(rails all)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    config.time_zone = 'UTC'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "<span class=\"fieldWithErrors\">#{html_tag}</span>" }
