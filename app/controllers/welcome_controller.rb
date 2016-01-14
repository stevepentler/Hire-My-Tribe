class WelcomeController < ApplicationController
  before_action :disable_navbar, only: [:index]

  def index
  end

  def new
    if current_user?
      flash[:error] = "Already logged in!"
      redirect_to root_path
    end

    @contractor = Contractor.new
  end
end
