Picsta::Application.routes.draw do



  #authenticated :user do
  #  root :to => "home#index"
  #  #root :to => 'albums#index'
  #end
  #root :to => "home#index"



  devise_for :users, :controllers => { :invitations => 'invitations',
                                         :registrations => "registrations" }


  resources :albums
  resources :activities, :only => [:index]
  resources :users, :only => [:show, :update, :index]
  resources :images, :only => [:show, :new, :create, :destroy, :index]

  match 'update_plan' => 'subscriptions#update_plan', :via => :put
  match 'update_card' => 'subscriptions#update_card', :via => :put


  resources :subscriptions, :only => [:new, :create, :edit, :update]

  get "static_pages/home"

  root :to => 'static_pages#home'
  match '/about' => 'static_pages#about'
  match '/privacy_policy' => 'static_pages#privacy'
  match '/more_info' => 'static_pages#more_info'
  match '/thanks' => 'static_pages#thanks'

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post

  match '/blog(:id)', to: 'blog#proxy', :id => /.+/

end