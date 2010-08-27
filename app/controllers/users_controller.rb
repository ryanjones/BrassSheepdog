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
      flash[:success] = "Profile updated."
      redirect_to edit_user_path(@user.id)
    else
      @title = "Edit user"
      @user.old_password = nil
      render 'edit'
    end
  end
  
  def edit
    @title = "Edit Settings"
  end
  
  def explicit_edit
    @title = "Edit Settings"
    @user = current_user
    render 'edit'
  end
  
  ###################################
  # Forgotten password actions
  ###################################
  
  def forgot
    @title = "Forgotten Login/Password"
  end
  
  def remind
    @user = User.find_by_email(params[:email])
    if @user
      @user.create_reset_token
      @user.send_reminder_email
      flash[:notice] = "A reminder e-mail has been sent to #{@user.email}"
      redirect_to root_path
    else
      flash[:error] = "No account was found for that e-mail."
      redirect_to forgot_users_path
    end
  end
  
  def new_password
    @title = "Reset Password"
    @user = User.find(params[:id])
    @token = params[:token]
    redirect_to root_path unless @user.check_reset_token @token
  end
  
  def reset
    @user = User.find(params[:id])
    if @user.check_reset_token params[:token]
      #this is for a check in the model
      @user.token = params[:token]
      if @user.update_attributes(params[:user])
        flash[:success] = "Password Succesfully Changed."
        @user.clear_reset_token
        redirect_to root_path
      else
        @title = "Reset Password"
        @user.password = nil
        @user.password_confirmation = nil
        render 'new_password'
      end
    else
      redirect_to root_path
    end
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
      #redirect_back_or_default(service_subscriptions_path)
      redirect_to(validation_path)
      flash[:notice] = "Thanks for signing up!"
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact us."
      render :action => 'new'
    end
  end
  
    
  def verify
    if current_user.verification_no == params[:verification_number]
      current_user.verified = true
      current_user.verification_no = nil
      flash[:success] = "Your phone number has been verified!  You can now recieve notifications."
      current_user.save
      if params[:page] == 'validation'
        redirect_to(service_subscriptions_path)
      else
        redirect_to :back
      end
    else
      flash[:error] = "Your verification number did not match."
      redirect_to :back
    end
  end
  
  def resend_verification
    if current_user.verification_try = nil || (current_user.verification_try != Date.today)
      current_user.send_verification_no
      current_user.verification_try = Date.today
      current_user.save
      flash[:success] = "Verification number resent!"
    else
      flash[:notice] = "You can only re-send 1 verification # per day!"
    end
    redirect_to :back
  end
 
  def validation_page
    @hide_verification_bar = true
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

