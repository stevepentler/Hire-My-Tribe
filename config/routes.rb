Rails.application.routes.draw do

  root to: "welcome#index"

  resources :developers, only: [:index]

end
