class ProjectsController < ApplicationController
  def create
    if current_contractor
      @developers = current_pending_tribe.developers
      total = current_pending_tribe.total
      session[:tribe] = []
      @project = current_contractor.projects.create(project_params.merge({total: total}))
      @project.developers += @developers
      flash[:project_added] = "New project created!"
      redirect_to contractor_project_path(@project)
    else
      redirect_to login_path
      flash[:error] = "Please login before submitting a project"
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
    developer = Developer.find(params[:dev])
    Project.find(params[:project_id]).developers -= [developer]
    redirect_to contractor_project_path(params[:project_id])
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
