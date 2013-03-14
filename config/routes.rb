Picsta::Application.routes.draw do



  authenticated :user do
    root :to => "home#index"
    #root :to => 'albums#index'
  end
  root :to => "home#index"



  devise_for :users, :controllers => { :invitations => 'invitations',
                                         :registrations => "registrations" }


  resources :albums
  resources :activities
  resources :users
  resources :images

  match 'update_plan' => 'subscriptions#update_plan', :via => :put
     #put 'update_card', :to => 'registrations#update_card'


  resources :subscriptions

  get "static_pages/home"

  match '/about' => 'static_pages#about'
  match '/privacy_policy' => 'static_pages#privacy'
  match '/thanks' => 'static_pages#thanks'

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post


end