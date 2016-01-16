class Developer < ActiveRecord::Base
  has_secure_password
  belongs_to :specialty
  has_many :project_developers
  has_many :projects, through: :project_developers

  def in_pending_tribe?(tribe)
    tribe.developer_ids.include?(id)
  end

  def inactive?
    status == "inactive"
  end
end
