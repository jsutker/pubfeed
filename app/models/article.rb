class Article < ActiveRecord::Base
  has_many :keyword_articles
  has_many :keywords, through: :keyword_articles
end
