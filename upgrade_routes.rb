Alertzy::Application.routes.draw do
  resources :service_subscriptions
  match '/signup' => 'users#new', :as => :signup
  match '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/edit' => 'users#explicit_edit', :as => :explicit_edit
  match '/unsubscribe' => 'service_subscriptions#destroy', :as => :unsubscribe

  resources :users do
    collection do
      get :forgot
      post :remind
    end

    member do
      put :reset
      get :new_password
    end
  end

  resource :sms_message, :only => [:new, :create] do
    member do
      post :incoming
    end
  end

  resource :address, :only => [:new, :create]
  resource :session
  resources :service_subscriptions, :only => [:edit, :index]
  resources :services, :only => [:index]
  match '/contact' => 'pages#contact', :as => :contact
  match '/services_list' => 'pages#services', :as => :services_list
  match '/about' => 'pages#about', :as => :about
  match '/faq' => 'pages#faq', :as => :faq
  match '/verify' => 'users#verify', :as => :verify
  match '/validation' => 'users#validation_page', :as => :validation
  match '/resend_verification' => 'users#resend_verification', :as => :resend_verification
  match '/' => 'pages#home'
  match '/:controller(/:action(/:id))'
end
