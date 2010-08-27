class ServiceSubscriptionsController < ApplicationController
  before_filter :login_required
  before_filter :set_header_link_class
  
  # GET /service_subscriptions
  # GET /service_subscriptions.xml
  def index
    @title = "Your subscriptions"
    @service_subscriptions = current_user.service_subscriptions

    respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @service_subscriptions }
    end
  end

  # GET /service_subscriptions/1
  # GET /service_subscriptions/1.xml
  def show
    @service_subscription = ServiceSubscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_subscription }
    end
  end

  # GET /service_subscriptions/new
  # GET /service_subscriptions/new.xml
  def new
    @service = Service.find_by_id(params[:service_id]) or redirect_to services_path
    
    @service_subscription = @service.subscriptions.build()
    @service_subscription.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_subscription }
    end
  end

  # GET /service_subscriptions/1/edit
  def edit
    @service_subscription = ServiceSubscription.find(params[:id])
  end

  # POST /service_subscriptions
  # POST /service_subscriptions.xml
  def create
      @service = Service.find(params[:service_id])
      
      @service_subscription = current_user.subscribe(@service, params[:service_subscription])
      
      if @service_subscription && @service_subscription.errors.empty?
        redirect_to service_subscriptions_path, :success => "You have subscribed to the service!"
      else
        render :action => :new
      end
 
  end

  # PUT /service_subscriptions/1
  # PUT /service_subscriptions/1.xml
  def update    
    @service_subscription = ServiceSubscription.find(params[:id])
    
      respond_to do |format|
        if @service_subscription.update_attributes(params[:service_subscription])
          format.html { redirect_to(service_subscriptions_path, :notice => 'Your settings were successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @service_subscription.errors, :status => :unprocessable_entity }
        end
      end
  end

  # DELETE /service_subscriptions/1
  # DELETE /service_subscriptions/1.xml
  def destroy
    @service_subscription = ServiceSubscription.find(params[:id])
    @service_subscription.destroy
    
    redirect_to service_subscriptions_path

    # respond_to do |format|
    #       format.html { redirect_to(service_subscriptions_url) }
    #       format.xml  { head :ok }
    #     end
  end
  
  private
    def set_header_link_class 
      @header_link_class = "subscriptions"
    end
end
