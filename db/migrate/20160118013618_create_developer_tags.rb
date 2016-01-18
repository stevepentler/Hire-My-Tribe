class CreateDeveloperTags < ActiveRecord::Migration
  def change
    create_table :developer_tags do |t|
      t.references :developer, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
    end
  end
end
