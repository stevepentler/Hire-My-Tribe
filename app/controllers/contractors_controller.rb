class ContractorsController < ApplicationController

def create
    @contractor = Contractor.new(contractor_params)
    if @contractor.save
      flash[:notice] = "Logged in as #{@contractor.first_name}"
      session[:contractor_id] = @contractor.id
      if session[:from_tribe] == true
        session[:from_tribe] = false
        redirect_to tribe_path
      else
        redirect_to contractor_path
      end
    else
      flash[:error] = @contractor.errors.full_messages.join(", ")
      redirect_to sign_up_path
    end
  end

  def show
    if params[:contractor_id]
      @contractor = Contractor.find(params[:contractor_id])
      render :public
    else
      render file: 'public/404.html' unless current_contractor
      @contractor = current_contractor
    end
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

  def index
    @contractors = Contractor.all
  end

private

  def contractor_params
    params.require(:contractor).permit(:company_name, :first_name, :last_name, :email, :password, :bio)
  end
end
