class Contractor < ActiveRecord::Base
  has_secure_password
  has_many :projects

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "defaults/default_contractor.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :status, presence: true

  def inactive?
    status == "inactive"
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
