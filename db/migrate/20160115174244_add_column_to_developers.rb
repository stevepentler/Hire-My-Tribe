class AddColumnToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :last_name, :string
    add_column :developers, :email, :string
    add_column :developers, :password_digest, :string
    add_column :developers, :bio, :text
  end
end
