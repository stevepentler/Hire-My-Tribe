class WelcomeController < ApplicationController
  before_action :disable_navbar, only: [:index]

  def index
  end

  def new
    if current_user?
      flash[:error] = "Already logged in!"
      redirect_to root_path
    end
    @developer = Developer.new
    @contractor = Contractor.new
  end

  def deactivate_account
  end

  def deactivate
    if current_contractor && current_contractor.authenticate(params[:deactivate][:password])
      current_contractor.update_attribute(:status, "inactive")
      session[:contractor_id] = nil
      flash[:notice] = "Account successfully deactivated."
      redirect_to root_path
    elsif current_developer && current_developer.authenticate(params[:deactivate][:password])
      current_developer.update_attribute(:status, "inactive")
      session[:developer_id] = nil
      flash[:notice] = "Account successfully deactivated."
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid login data'
      redirect_to deactivate_account_path
    end
  end

end
