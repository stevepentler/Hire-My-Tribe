class Specialty < ActiveRecord::Base
  has_many :developers

  validates :name, presence: true, uniqueness: true
  validates :url_name, presence: true, uniqueness: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "defaults/default_totem.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def to_param
    url_name
  end
end
