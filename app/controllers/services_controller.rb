class ServicesController < ApplicationController
  before_filter :set_header_link_class
  
  def index
    @title = "Available Services"
    @services = Service.find(:all, :conditions => { :enabled => true })
  end
  
  def show
    @service = Service.find_by_id(params[:id])
  end
  
  private
    def set_header_link_class 
      @header_link_class = "subscriptions"
    end

end
