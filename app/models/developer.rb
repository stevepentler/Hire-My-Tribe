class Developer < ActiveRecord::Base
  belongs_to :specialty
  has_many :project_developers
  has_many :projects, through: :project_developers

  def in_pending_tribe?(tribe)
    tribe.developer_ids.include?(id)
  end

  def set_speciality(new_specialty)
    self.specialty = new_specialty
  end
end
