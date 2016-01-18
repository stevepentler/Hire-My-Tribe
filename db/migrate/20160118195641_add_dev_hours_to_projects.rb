class AddDevHoursToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :dev_hours, :integer, default: 0
  end
end
