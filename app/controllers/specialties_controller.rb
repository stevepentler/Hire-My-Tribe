class SpecialtiesController < ApplicationController
  def show
    session[:specialty] = Specialty.find_by(url_name: params[:id]).id
    @developers = current_specialty.developers
  end
end
