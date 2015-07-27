class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :abstract
      t.integer :id_from_json
      t.string :authors
      t.string :journal
      t.string :related_keywords
      t.timestamps null: false
    end
  end
end
