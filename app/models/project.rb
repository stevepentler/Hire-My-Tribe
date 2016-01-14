class Project < ActiveRecord::Base
  belongs_to :contractor
  has_many :project_developers
  has_many :developers, through: :project_developers

  enum status: ["Pending", "Paid & Active", "Completed", "Cancelled"]

end
