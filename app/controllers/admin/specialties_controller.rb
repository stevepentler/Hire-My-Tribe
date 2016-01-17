class Admin::SpecialtiesController < Admin::BaseController
  def new
    @specialty = Specialty.new
  end

  def create
    @specialty = Specialty.new(specialty_params)
    if @specialty.save
      flash[:success] = "Specialty successfully created!"
      redirect_to admin_specialties_path
    else
      render :new
    end
  end

  def index
    @specialties = Specialty.all
  end

  private
    def specialty_params
      params.require(:specialty).permit(:name, :description, :url_name, :image)
    end
end
