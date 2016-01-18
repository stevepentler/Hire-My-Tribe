class Developer < ActiveRecord::Base
  has_secure_password
  belongs_to :specialty
  has_many :project_developers
  has_many :projects, through: :project_developers

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "defaults/default_developer.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :rate, presence: true, numericality: true
  validates :status, presence: true
  validates :specialty_id, presence: true


  def in_pending_tribe?(tribe)
    tribe.developer_ids.include?(id)
  end

  def inactive?
    status == "inactive"
  end
end
