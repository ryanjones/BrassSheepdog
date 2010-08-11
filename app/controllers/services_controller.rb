class ServicesController < ApplicationController
  def index
    @services = Service.all
  end

end
