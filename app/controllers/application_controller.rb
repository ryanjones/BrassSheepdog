# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #use the default layout unless overridden
  layout "default"
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  # set the timezone to a users setting
  before_filter :set_user_time_zone
  
  private
  
    #note that the users timezone is currently a fake attribute
    def set_user_time_zone
      Time.zone = current_user.time_zone if logged_in?
    end
  
end
