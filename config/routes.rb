Picsta::Application.routes.draw do



  resources :albums do
    resource :shares, only: [:create, :destroy,:new]
  end


  authenticated :user do
    root :to => "home#index"
    #root :to => 'albums#index'
  end
  root :to => "home#index"



  if Rails.env == 'production' or Rails.env == 'development'
    devise_for :users, :controllers => { :invitations => 'invitations',
                                         :registrations => "registrations" }
  else
    devise_for :users, :controllers => { :invitations => 'invitations' }
  end


  resources :activities
  resources :users
  resources :shares, only: [:create, :destroy, :update]
  resources :images

  get "static_pages/home"
  #get "static_pages/about"
  match '/about' => 'static_pages#about'
  match '/privacy_policy' => 'static_pages#privacy'

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post


end