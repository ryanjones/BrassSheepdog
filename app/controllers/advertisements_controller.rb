class AdvertisementsController < ApplicationController
  respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  def services_post
    #this needs to be cleaned up. Add and delete. Check if it exists, then add if it doesnt
    message=""

    case params[:oper]
    when 'add'
      service = Service.find_by_id(params[:id])
      ad = Advertisement.find_by_id(params[:parent_id])
      ad.services << service
  
      advertisement = Advertisement.create(advertisement_params)
      message << ('add ok') if advertisement.errors.empty?
    when 'del'
      ad = Advertisement.find_by_id(params[:parent_id])
      message <<  ('del ok') if advertisement.errors.empty?
    else
      message <<  ('unknown action')
    end
    
    if request.xhr?
      render :json => ad.services.to_jqgrid_json([:service_id, :display_name], 1, 1, total_entries) and return
    end
  end
  
  
  def services
    if params[:id].present?
      ad = Advertisement.find_by_id(params[:id])
      services = ad.services

      total_entries = services.count
    else
      services = []
      total_entries = 0
    end
    if request.xhr?
      render :json => services.to_jqgrid_json([:service_id, :display_name], 1, 1, total_entries) and return
    end
  end

  def post_data
    message=""
    advertisement_params = { :id => params[:id],:name => params[:name],:company => params[:company],:enabled => params[:enabled],:credits => params[:credits],:content => params[:content] }

    case params[:oper]
    when 'add'
      if params["id"] == "_empty"
        advertisement = Advertisement.create(advertisement_params)
        message << ('add ok') if advertisement.errors.empty?
      end
      
    when 'edit'
      advertisement = Advertisement.find(params[:id])
      message << ('update ok') if advertisement.update_attributes(advertisement_params)
    when 'del'
      Advertisement.destroy_all(:id => params[:id].split(","))
      message <<  ('del ok')
    when 'sort'
      advertisements = Advertisement.all
      advertisements.each do |advertisement|
        advertisement.position = params['ids'].index(advertisement.id.to_s) + 1 if params['ids'].index(advertisement.id.to_s) 
        advertisement.save
      end
      message << "sort ak"
    else
      message <<  ('unknown action')
    end
    
    unless (advertisement && advertisement.errors).blank?  
      advertisement.errors.entries.each do |error|
        message << "<strong>#{Advertisement.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
      end
      render :json =>[false,message]
    else
      render :json => [true,message] 
    end
  end
  
  
  def index
    index_columns ||= [:id,:name,:company,:enabled,:credits,:content]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] unless (params[:sidx].blank? || params[:sord].blank?)
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @advertisements=Advertisement.paginate(conditions)
    total_entries=@advertisements.total_entries
    
    respond_with(@advertisements) do |format|
      format.json { render :json => @advertisements.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end
  end

end




# services = Service.select('*').joins(:advertisements).where('advertisements.id = 6', params[:id])