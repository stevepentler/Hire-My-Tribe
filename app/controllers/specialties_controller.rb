class SpecialtiesController < ApplicationController
  def show
    @developers = Specialty.find_by(url_name: params[:id]).developers
  end
end
