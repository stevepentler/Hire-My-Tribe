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

private

  def contractor_params
    params.require(:contractor).permit(:company_name, :first_name, :last_name, :email, :password)
  end

end
