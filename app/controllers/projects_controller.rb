class ProjectsController < ApplicationController
  def create
    if current_contractor
      @project = Project.create(project_constructor_params)

      session[:tribe] = []
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

  def project_constructor_params
    project_params.merge(
      total: current_pending_tribe.total,
      contractor: current_contractor,
      developers: current_pending_tribe.developers
      )
  end
end
