class ProjectsController < ApplicationController
  def create
    @developers = @ptribe.developers
    total = @ptribe.total 
    session[:tribe] = []
    @project = current_contractor.projects.create(project_params.merge({total: total}))
    @project.developers += @developers 
    redirect_to contractor_project_path(@project)
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

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end 
end 