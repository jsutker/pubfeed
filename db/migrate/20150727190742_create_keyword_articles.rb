class CreateKeywordArticles < ActiveRecord::Migration
  def change
    create_table :keyword_articles do |t|
      t.integer :keyword_id
      t.integer :article_id
      t.timestamps null: false
    end
  end
end
