class WelcomeController < ApplicationController
  before_action :disable_navbar, only: [:index]

  def index
  end

  def new
    @contractor = Contractor.new
  end
end
