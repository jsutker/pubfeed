class ChangeAuthorColumnToTextAndRemoveRelatedKeywords < ActiveRecord::Migration
  def change
    change_column :articles, :authors, :text
    remove_column :articles, :related_keywords
  end
end
