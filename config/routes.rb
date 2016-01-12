Rails.application.routes.draw do
  root to: "welcome#index"

  namespace :developers do
    get 'database_specialty', to: "specialty#database"
    get 'front_end_specialty', to: "specialty#front_end"
    get 'back_end_specialty', to: "specialty#back_end"
  end

  resources :developers, only: [:index, :show]

  resource :tribe, only: [:create, :show]

  #/developers/database_specialty

  #/specialty/database/developers
  # resources :specialty, only: [:show] do
  #   resources :developers
  # end
end
