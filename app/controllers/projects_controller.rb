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
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end 
end 