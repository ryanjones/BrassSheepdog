ActionController::Routing::Routes.draw do
  
  # Singular Resources
  match 'signup' => 'users#new'
  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'
  match 'edit' => 'users#explicit_edit'
  match 'unsubscribe' => 'service_subscriptions#destroy'
  
  match 'contact' => 'pages#contact'
  match 'contact_submit' => 'pages#contact_submit', :via => :post

  match 'services_list' => 'pages#services'
  match 'about' => 'pages#about'
  match 'faq' => 'pages#faq'
  
  match 'verify' => 'users#verify'
  match 'validation' => 'users#validation_page'
  match 'resend_verification' => 'users#resend_verification'

  # Resources
  resources :users do
      collection do 
        get :forgot
        post :remind
      end
      
      member do
        get :new_password
        put :reset
      end
    end
  resources :service_subscriptions
  resources :services, :only => [:index]
  resources :advertisements, :only => [:index] do
    collection do
      post "post_data"
    end
  end
  
  # Resource
  resource :sms_message, :only => [:new, :create, :incoming] do
      member do
        post :incoming
      end
    end
  resource :address, :only => [:new, :create]
  resource :session

  # Root
  root :to => 'pages#home'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # See how all your routes lay out with 'rake routes'

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #connect ':controller/:action/:id'
  #connect ':controller/:action/:id.:format'

end
