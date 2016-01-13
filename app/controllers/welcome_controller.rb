class WelcomeController < ApplicationController
  before_action :disable_navbar, only: [:index]
  def index
  end

end
