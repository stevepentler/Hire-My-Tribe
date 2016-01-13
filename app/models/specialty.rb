class Specialty < ActiveRecord::Base
  has_many :developers

  def to_param
    url_name
  end
end
# speciality_path(@speciality) == "/specialites/#{to_param(@speciality)}"
