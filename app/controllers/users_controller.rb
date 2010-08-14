class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :set_header_link_class
  # render new.rhtml
  def new
    @title = "Create a new user"
    @user = User.new
  end
  
  def update
    if @user.update_attributes(params[:user])
      @user.verified = false
      @user.send_verification_no
      flash[:success] = "Profile updated."
      redirect_to root_path
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def edit
    @title = "Edit Settings"
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      @user.send_verification_no
      redirect_back_or_default(service_subscriptions_path)
      flash[:notice] = "Thanks for signing up!"
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
    
  def verify
    if current_user.verification_no == params[:verification_number]
      current_user.verified = true
      flash[:notice] = "Your phone number has been verified!  You can now recieve updates."
      current_user.save
      redirect_to(root_path)
    else
      redirect_to(root_path)
    end
  end
  
  def resend_verification
    current_user.send_verification_no 
    redirect_to(root_path)
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def set_header_link_class 
      @header_link_class = "settings"
    end
    
end

