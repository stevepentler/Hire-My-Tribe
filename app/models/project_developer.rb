class ProjectDeveloper < ActiveRecord::Base
  belongs_to :developer
  belongs_to :project
end 