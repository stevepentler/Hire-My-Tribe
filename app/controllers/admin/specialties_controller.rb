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

  def edit
    # binding.pry
    @specialty = Specialty.find_by(url_name: params[:id])
  end

  def update
    @specialty = Specialty.find_by(url_name: params[:id])
    @specialty.update(specialty_params)
    redirect_to admin_specialties_path
  end

  private
    def specialty_params
      params.require(:specialty).permit(:name, :description, :url_name, :image)
    end
end
