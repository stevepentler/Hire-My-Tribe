class Tag < ActiveRecord::Base
  has_many :developer_tags
  has_many :developers, through: :developer_tags

  validates :name, presence: true, uniqueness: true
end
