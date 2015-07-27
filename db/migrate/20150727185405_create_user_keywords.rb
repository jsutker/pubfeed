class CreateUserKeywords < ActiveRecord::Migration
  def change
    create_table :user_keywords do |t|
      t.integer :user_id
      t.integer :keyword_id
      t.timestamps null: false
    end
  end
end
