class ContractorsController < ApplicationController

  def create
    @contractor = Contractor.new(contractor_params)
    if @contractor.save
      flash[:notice] = "Logged in as #{@contractor.first_name}"
      session[:contractor_id] = @contractor.id
      redirect_to contractor_path
    else
      flash[:error] = @contractor.errors.full_messages.join(", ")
    end
  end

  def show
    render file: 'public/404.html' unless current_contractor
    @contractor = current_contractor
  end

  def edit
  end

  def update
    if current_contractor.save
      flash[:notice] = "Account information edited!"
      current_contractor.update(contractor_params)
      redirect_to contractor_path
    else
      flash[:error] = current_contractor.errors.full_messages.join(", ")
    end
  end

  def deactivate_account
  end

  def deactivate
    if current_contractor && current_contractor.authenticate(params[:contractor][:password])
      current_contractor.update_attribute(:status, "inactive")
      session[:contractor_id] = nil
      flash[:notice] = "Account successfully deactivated."
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid login data'
      redirect_to deactivate_account_path
    end
  end

private

  def contractor_params
    params.require(:contractor).permit(:company_name, :first_name, :last_name, :email, :password, :bio)
  end

end