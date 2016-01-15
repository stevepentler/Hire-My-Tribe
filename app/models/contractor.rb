class Contractor < ActiveRecord::Base
  has_secure_password
  has_many :projects

  # def deactivate
  #   update_attribute(:status, "inactive")
  # end

  def inactive?
    status == "inactive"
  end

end