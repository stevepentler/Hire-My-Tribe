Rails.application.routes.draw do
  root to: "welcome#index"

  # namespace :developers do
  #   # get 'database_specialty', to: "specialty#database"
  #   # get 'front_end_specialty', to: "specialty#front_end"
  #   # get 'back_end_specialty', to: "specialty#back_end"
  # end

  resources :developers, only: [:index, :show]

  resource :tribe, only: [:create, :show, :destroy]

  resources :specialties, only:[:show]

  #/developers/database_specialty

  #/specialty/database/developers
  # resources :specialty, only: [:show] do
  #   resources :developers
  # end
end
#
# Rails.application.routes.draw do
# root to: "welcome#index"
#
# # scope :developers do
# #   get ':specialty', to: "specialty#show"
# # end
#
# resources :specialties, only: [:show], param: :name
#
# resources :developers, only: [:index, :show]
#
# resource :tribe, only: [:create, :show]
#
# #/developers/database_specialty
#
# #/specialty/database/developers
# # resources :specialty, only: [:show] do
# #   resources :developers
# # end
# end
#
# [3:39]
# class SpecialtyController < ApplicationController
# def show
#   @specialty = Specialty.find_by(name: params[:name])
# end
# end
