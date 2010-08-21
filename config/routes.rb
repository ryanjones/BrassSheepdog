ActionController::Routing::Routes.draw do |map|
  map.resources :service_subscriptions

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.explicit_edit '/edit', :controller => 'users', :action => 'explicit_edit'
  
  map.unsubscribe '/unsubscribe', :controller => 'service_subscriptions', :action => 'destroy'

  map.resources :users, :collection => { :forgot => :get, :remind => :post}, :member => { :reset => :put, :new_password => :get}
  map.resource :sms_message, :only => [:new, :create], :member => {:incoming => :post}
  map.resource :address, :only => [:new, :create]
  map.resource :session
  map.resources :service_subscriptions, :only => [:edit, :index]
  map.resources :services, :only => [:index, :show]

  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.services_list   '/services_list',   :controller => 'pages', :action => 'services'
  map.about   '/about',   :controller => 'pages', :action => 'about'
  map.help    '/help',    :controller => 'pages', :action => 'help'
  
  map.verify  '/verify', :controller => 'users', :action => 'verify'
  map.resend_verification  '/resend_verification', :controller => 'users', :action => 'resend_verification'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => "pages", :action => "home"


  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
