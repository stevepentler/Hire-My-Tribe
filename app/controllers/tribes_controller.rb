class TribesController < ApplicationController

  def create
    developer = Developer.find(params[:developer_id])
    flash[:notice] = "#{developer.name} has joined your tribe!"

    session[:tribe] ||= []
    session[:tribe] << developer.id

    redirect_to developers_path
  end

  def show
    @developers = session[:tribe].map do |developer_id|
      Developer.find(developer_id)
    end
    
    @total = @developers.reduce(0) do |acc, developer|
      acc + developer.rate.to_i
    end
  end

end
