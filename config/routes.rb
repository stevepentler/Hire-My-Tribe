Rails.application.routes.draw do

  root to: "welcome#index"

  resources :developers, only: [:index]

  namespace :developers do
    get 'database_specialty', to: "specialty#database"
    get 'front_end_specialty', to: "specialty#front_end"
    get 'back_end_specialty', to: "specialty#back_end"
  end

end