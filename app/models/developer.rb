class Developer < ActiveRecord::Base
  has_secure_password
  belongs_to :specialty
  has_many :project_developers
  has_many :projects, through: :project_developers
  has_many :developer_tags
  has_many :tags, through: :developer_tags

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "defaults/default_developer.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :rate, presence: true, numericality: true
  validates :skills_rating, inclusion: { in: [0,1,2,3,4,5] }
  validates :status, presence: true
  validates :specialty_id, presence: true


  def in_pending_tribe?(tribe)
    tribe.developer_ids.include?(id)
  end

  def inactive?
    status == "inactive"
  end

  def tag_name_list
    self.tags.all.map { |tag| tag.name }
  end
end
