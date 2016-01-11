class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.string :profile_picture
      t.string :specialty
      t.float :rate

      t.timestamps null: false
    end
  end
end
