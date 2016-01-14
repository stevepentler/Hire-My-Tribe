class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.string :company_name, default: ""
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.text :bio, default: ""

      t.timestamps null: false
    end
  end
end
