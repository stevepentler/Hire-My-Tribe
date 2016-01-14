class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :status, default: 0
      t.integer :total
      t.references :contractor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
