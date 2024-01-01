Rails.application.routes.draw do
  
  get 'home' => 'home#index', :as => :home

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users
  resources :posts do
    resources :comments, only: [:create, :edit, :destroy], shallow: true
  end
  
  root "start_page#start_page"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
