class TribesController < ApplicationController

  def create
    developer = Developer.find(params[:developer_id])
    flash[:notice] = "#{developer.name} has joined your tribe!"
    @ptribe.add(developer.id)
    redirect_to developers_path
  end

  def show
    @project = Project.new
  end

  def destroy
    @ptribe.remove(params[:developer_id].to_i)
    redirect_to tribe_path
  end

end
