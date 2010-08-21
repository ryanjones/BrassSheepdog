class AddressesController < ApplicationController
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
    
  end

end
