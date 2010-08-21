class AddressesController < ApplicationController
  before_filter :login_required
  before_filter :set_header_link_class
  
  def new
    @title = "Address Lookup"
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    if @address
      render :show
    else
      render :new
    end
  end
  
  def lookup_zone
    @address = Address.new(:address_string => params[:address])
    @zone = @address.formatted_zone
  end


  private
    def set_header_link_class 
      @header_link_class = "address"
    end
end
