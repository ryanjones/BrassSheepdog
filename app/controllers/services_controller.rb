class ServicesController < ApplicationController
  before_filter :set_header_link_class
  
  def index
    @services = Service.all
  end
  
  def show
    @service = Service.find_by_id(params[:id])
  end
  
  private
    def set_header_link_class 
      @header_link_class = "subscriptions"
    end

end
