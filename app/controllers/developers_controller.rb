class DevelopersController < ApplicationController
  def index
    session[:specialty] = nil
    @developers = Developer.all
  end

  def show
    @developer = Developer.find(params[:id])
  end
end
