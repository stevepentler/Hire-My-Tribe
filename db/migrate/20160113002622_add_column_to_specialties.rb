class AddColumnToSpecialties < ActiveRecord::Migration
  def change
    add_column :specialties, :url_name, :string
  end
end
