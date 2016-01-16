class Developer < ActiveRecord::Base
  has_secure_password
  belongs_to :specialty
  has_many :project_developers
  has_many :projects, through: :project_developers

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates :profile_picture, presence: true
  validates :rate, presence: true
  # validates :status, presence: true
  # validates :specialty_id, presence: true
  

  def in_pending_tribe?(tribe)
    tribe.developer_ids.include?(id)
  end

  def inactive?
    status == "inactive"
  end
end
