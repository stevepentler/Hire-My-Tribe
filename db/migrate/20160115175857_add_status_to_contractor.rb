class AddStatusToContractor < ActiveRecord::Migration
  def change
    add_column :contractors, :status, :string, default: "active"
  end
end
