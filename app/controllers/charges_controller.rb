class ChargesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    if @project.developers.any? {|dev| dev.status == 'unavailable'}
      flash[:error] = "Some of your developers are unavailable"
      redirect_to contractor_project_path(@project)
    else
    end
  end

  def create
    @project = Project.find(params[:project_id])

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => (project_cost(@project) * 100),
      :description => 'Hire My Tribe',
      :currency    => 'usd'
    )
    redirect_to contractor_project_payment_path(@project)
    flash[:payment] = "Thank you for your payment of #{project_cost(@project)}"
  rescue Stripe::CardError => e
    flash[:error] = e.message
  end
end
