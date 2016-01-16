class Contractor < ActiveRecord::Base
  has_secure_password
  has_many :projects

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :status, presence: true

  def inactive?
    status == "inactive"
  end
end
