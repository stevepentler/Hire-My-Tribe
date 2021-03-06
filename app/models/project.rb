class Project < ActiveRecord::Base
  belongs_to :contractor
  has_many :project_developers
  has_many :developers, through: :project_developers

  enum status: ["Pending", "Paid & Active", "Completed", "Cancelled"]

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  def remove(developer_id)
    self.developers -= [developers.find_by(id: developer_id)]
  end
end
