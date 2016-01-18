class AddRatingAndPictureToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :skills_rating, :integer
    add_attachment :developers, :picture
    remove_column :developers, :profile_picture, :string
  end
end
