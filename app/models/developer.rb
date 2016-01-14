class Developer < ActiveRecord::Base
  belongs_to :specialty
  has_many :project_developers
  has_many :projects, through: :project_developers
end
