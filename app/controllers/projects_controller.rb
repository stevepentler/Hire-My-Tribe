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

  def pay
    @project = Project.find(params[:project_id])
    @project.pay_project
    redirect_to contractor_project_path(@project)
  end

  def complete
    @project = Project.find(params[:project_id])
    @project.complete_project
    flash[:sucess] = "Project Complete - Congratulations!"
    redirect_to contractor_project_path(@project)
  end

  def cancel
    @project = Project.find(params[:project_id])
    @project.cancel_project
    flash[:sucess] = "The Project has been cancelled"
    redirect_to contractor_project_path(@project)
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
      developers: current_pending_tribe.developers,
      dev_hours: params[:project][:dev_hours]
      )
  end
end
