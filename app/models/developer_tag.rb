class DeveloperTag < ActiveRecord::Base
  belongs_to :developer
  belongs_to :tag
end
