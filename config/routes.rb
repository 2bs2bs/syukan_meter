Rails.application.routes.draw do
  root "start_page#start_page"

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  get 'home' => 'home#index', :as => :home

  resources :users
  resource :profile, only: %i[edit update]

  resources :posts do
    resources :comments, only: [:create, :edit, :destroy], shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]

  resources :pomodoros, only: %i[index new create show]

  resources :calendars, only: %i[index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
