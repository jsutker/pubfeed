class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :title
      t.text :abstract
      t.integer :id_from_json
      t.string :authors
      t.string :journal
      t.string :related_keywords
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
