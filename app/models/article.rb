class Article < ActiveRecord::Base
  has_many :keyword_articles
  has_many :keywords, through: :keyword_articles

  def url
    "http://www.ncbi.nlm.nih.gov/pubmed/?term=#{self.id_from_json}"
  end

end
