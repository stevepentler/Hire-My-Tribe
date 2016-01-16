class Specialty < ActiveRecord::Base
  has_many :developers
  
  validates :name, presence: true, uniqueness: true
  validates :url_name, presence: true, uniqueness: true

  def to_param
    url_name
  end
end