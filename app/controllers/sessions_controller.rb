class SessionsController < ApplicationController

  def new
    if current_user?
      flash[:error] = "Already logged in!"
      redirect_to root_path
    end
  end

  def create
    session[:developer_id] = nil
    session[:contractor_id] = nil
    if admin = Admin.find_by(email: params[:session][:email])
      if admin.authenticate(params[:session][:password])
        flash[:notice] = "Logged in as #{admin.username}"
        session[:admin_id] = admin.id 
        redirect_to admin_dashboard_path
      else
        flash.now[:error] = 'Invalid login data'
        render :new
      end
    elsif params[:commit] == "Developer Login"
      create_developer
    elsif  params[:commit] == "Contractor Login"
      create_contractor
    end
  end

  def create_contractor
    contractor = Contractor.find_by(email: params[:session][:email])
    if contractor && contractor.inactive?
      inactive_user
    elsif contractor && contractor.authenticate(params[:session][:password])
      flash[:notice] = "Logged in as #{contractor.first_name}"
      session[:contractor_id] = contractor.id
      if session[:from_tribe] == true
        session[:from_tribe] = false
        redirect_to tribe_path
      else
        redirect_to contractor_path
      end
    else
      invalid_login
    end
  end

  def create_developer
    developer = Developer.find_by(email: params[:session][:email])
    if developer && developer.inactive?
      inactive_user
    elsif developer && developer.authenticate(params[:session][:password])
      flash[:notice] = "Logged in as #{developer.name}"
      session[:developer_id] = developer.id
      redirect_to developer_path
    else
      invalid_login
    end
  end

  def inactive_user
    flash[:error] = "Inactive account. Contact admin to reactivate account."
    redirect_to login_path
  end

  def invalid_login
    flash.now[:error] = 'Invalid login data'
    render :new
  end

  def destroy
    flash[:notice] = "Logged out #{current_contractor.first_name}" if current_contractor
    flash[:notice] = "Logged out #{current_developer.name}" if current_developer
    flash[:notice] = "Logged out #{current_admin.username}" if current_admin

    session[:contractor_id] = nil
    session[:developer_id] = nil
    session[:admin_id] = nil

    redirect_to login_path
  end

end
