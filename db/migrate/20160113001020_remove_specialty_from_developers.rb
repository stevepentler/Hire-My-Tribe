class RemoveSpecialtyFromDevelopers < ActiveRecord::Migration
  def change
    remove_column :developers, :specialty, :string
    add_reference :developers, :specialty, index: true, foreign_key: true
  end
end
