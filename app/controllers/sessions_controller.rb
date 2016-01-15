class SessionsController < ApplicationController

  def new
    if current_user?
      flash[:error] = "Already logged in!"
      redirect_to root_path
    end

  end

  def create
    session[:developer_id] = nil
    contractor = Contractor.find_by(email: params[:session][:email])
    if contractor.inactive?
      flash[:error] = "Inactive account. Contact admin to reactivate account."
      redirect_to login_path
    elsif contractor && contractor.authenticate(params[:session][:password])
      flash[:notice] = "Logged in as #{contractor.first_name}"
      session[:contractor_id] = contractor.id
      redirect_to contractor_path
    else
      flash.now[:error] = 'Invalid login data'
      render :new
    end
  end

  def destroy
    flash[:notice] = "Logged out #{current_contractor.first_name}" if current_contractor
    flash[:notice] = "Logged out #{current_developer.first_name}" if current_developer

    session[:contractor_id] = nil
    session[:developer_id] = nil

    redirect_to login_path
  end

end
