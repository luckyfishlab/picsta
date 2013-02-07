Sugar::Application.routes.draw do
  resources :albums do
    resource :shares, only: [:create, :destroy,:new]
  end


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :shares, only: [:create, :destroy]

end