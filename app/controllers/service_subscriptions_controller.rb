class ServiceSubscriptionsController < ApplicationController
  before_filter :login_required
  
  # GET /service_subscriptions
  # GET /service_subscriptions.xml
  def index
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
    @service_subscription = ServiceSubscription.new

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
    result = current_user.subscribe!(@service)
    
    redirect_to edit_service_subscription_path(result.id)

    # respond_to do |format|
    #      if result
    #        format.html { redirect_to(@service_subscription, :notice => 'ServiceSubscription was successfully created.') }
    #        format.xml  { render :xml => @service_subscription, :status => :created, :location => @service_subscription }
    #      else
    #        format.html { render :action => "new" }
    #        format.xml  { render :xml => @service_subscription.errors, :status => :unprocessable_entity }
    #      end
    #    end
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
end
