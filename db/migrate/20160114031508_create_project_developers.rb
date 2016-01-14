class CreateProjectDevelopers < ActiveRecord::Migration
  def change
    create_table :project_developers do |t|
      t.references :project, index: true, foreign_key: true
      t.references :developer, index: true, foreign_key: true
    end
  end
end
