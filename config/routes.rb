Picsta::Application.routes.draw do

  resources :albums do
    resource :shares, only: [:create, :destroy,:new]
  end


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  if Rails.env == 'production'
    devise_for :users, :controllers => { :registrations => "registrations" }
  else
    devise_for :users
  end

  resources :users
  resources :shares, only: [:create, :destroy]
  resources :images

  get "static_pages/home"
  #get "static_pages/about"
  match '/about' => 'static_pages#about'
  match '/privacy_policy' => 'static_pages#privacy'

end