class AddStatusToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :status, :string, default: "available"
  end
end
