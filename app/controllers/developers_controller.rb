class DevelopersController < ApplicationController
  def index
    session[:specialty] = nil
    @developers = Developer.order(updated_at: :desc)
    @tags = Tag.all
  end

  def create
    @developer = Developer.new(developer_constructor_params)
    if @developer.save
      flash[:notice] = "Logged in as #{@developer.name}"
      session[:developer_id] = @developer.id
      redirect_to developer_path
    else
      flash[:error] = @developer.errors.full_messages.join(", ")
      redirect_to sign_up_path
    end
  end

  def show
    if params[:id]
      @developer = Developer.find(params[:id])
    elsif current_developer
      render :current_developer
    else
      render file: "public/404.html"
    end
  end

  def update
    flash[:notice] = "Account information edited!"
    current_developer.update(developer_constructor_params)
    redirect_to developer_path
  end

  def edit
  end

  def filter
    @tags = Tag.all
    @developers = Filter.sort_filter(params)
    flash.now[:notice] = "Filter has been applied!"
    render :index
  end

private

  def developer_params
    params.require(:developer).permit(:name,:last_name, :email, :password, :bio, :rate, :picture)
  end

  def developer_constructor_params
    developer_params.merge(specialty_id: params[:Specialties])
  end
end
