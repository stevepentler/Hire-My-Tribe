Rails.application.routes.draw do
  root to: "welcome#index"

  resources :developers, only: [:index, :show]
  resource :tribe, only: [:create, :show, :destroy]
  resources :specialties, only:[:show]
  resource :contractor, only: [:create, :show] do
    resources :projects, only: [:create, :show] do
      get 'payment', to: "projects#submit_payment"
    end
  end

  # resources :contractors, only: [:create, :show]
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/sign_up', to: "welcome#new"

end
