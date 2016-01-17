class AddImageToSpecialties < ActiveRecord::Migration
  def change
    add_attachment :specialties, :image
  end
end
