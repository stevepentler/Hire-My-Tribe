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
      deactivate_user(current_contractor, :contractor_id)
    elsif current_developer && current_developer.authenticate(params[:deactivate][:password])
      deactivate_user(current_developer, :developer_id)
    else
      flash.now[:error] = "Invalid login data"
      redirect_to deactivate_account_path
    end
  end

private

  def deactivate_user(user, type)
    user.update_attribute(:status, "inactive")
    session[type] = nil
    flash[:notice] = "Account successfully deactivated."
    redirect_to root_path
  end
end
