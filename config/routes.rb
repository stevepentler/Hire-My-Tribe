Rails.application.routes.draw do
  root to: "welcome#index"

  resources :developers, only: [:index, :show]
  resource :developer, only: [:show, :create, :edit, :update]

  resource :tribe, only: [:create, :show, :destroy]
  resources :specialties, only:[:show]

  resource :contractor, only: [:create, :show, :edit, :update] do
    resources :projects, only: [:create, :show, :index] do
      delete 'remove_dev', to: "projects#remove_dev"
      get 'payment', to: "projects#submit_payment"
      post 'payment', to: "projects#pay"
      patch 'complete', to: "projects#complete"
      patch 'cancel', to: "projects#cancel"
    end
  end

  resources :contractors, only:[:index]
  resources :projects, only: [:show]

  namespace :admin do
    resources :specialties, only: [:new, :create, :index]
    resources :tags, except: [:show]
    get '/dashboard', to: "admins#show"
    patch '/rate_developer', to: 'developers#rate'
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/sign_up', to: "welcome#new"
  get '/deactivate_account', to: "welcome#deactivate_account"
  post '/deactivate', to: "welcome#deactivate"
  post '/filter', to: "developers#filter"
end
