class SessionsController < ApplicationController

  def new
  end

  def create
    session[:developer_id] = nil
    contractor = Contractor.find_by(email: params[:session][:email])
    if contractor && contractor.authenticate(params[:session][:password])
      flash[:notice] = "Logged in as #{contractor.first_name}"
      session[:contractor_id] = contractor.id
      redirect_to contractor_path
    else
      flash[:error] = 'Invalid login data'
      render :new
    end
  end

end
