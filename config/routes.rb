Rails.application.routes.draw do
  root to: "welcome#index"

  resources :developers, only: [:index, :show]
  resource :tribe, only: [:create, :show, :destroy]
  resources :specialties, only:[:show]
  resource :contractor, only: [:create, :show] do 
    resources :projects, only: [:create, :show]
  end

  # resources :contractors, only: [:create, :show]
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/sign_up', to: "welcome#new"
end
