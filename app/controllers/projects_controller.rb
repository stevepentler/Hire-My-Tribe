class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_constructor_params)

    if current_contractor
      if @project.save
        @pending_tribe = PendingTribe.new
        flash[:project_added] = "New project created!"
        redirect_to contractor_project_path(@project)
      else 
      flash[:error] = @project.errors.full_messages.join(", ")
      redirect_to tribe_path
      end 
    else
      session[:from_tribe] = true
      flash[:login_error] = "Please login before submitting a project"
      redirect_to login_path
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def index
    @projects = Project.all
  end

  def submit_payment
    @project = Project.find(params[:project_id])
  end

  def remove_dev
    Project.find(params[:project_id]).remove(params[:dev])
    redirect_to contractor_project_path(params[:project_id])
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def project_constructor_params
    project_params.merge(
      total: current_pending_tribe.total,
      contractor: current_contractor,
      developers: current_pending_tribe.developers
      )
  end
end
