class Article < ActiveRecord::Base
  has_many :keyword_articles
  has_many :keywords, through: :keyword_articles

  def url
    "http://www.ncbi.nlm.nih.gov/pubmed/?term=#{self.id_from_json}"
  end

  def self.find_or_create_abstracts(articleHash, id_from_json)
    find_or_create_by(title: find_title(articleHash), abstract: find_abstract(articleHash), id_from_json: id_from_json, journal: find_journal(articleHash), authors: find_authors(articleHash))
  end

  def self.find_title(articleHash)
    articleHash["ArticleTitle"]
  end

  def self.find_abstract(articleHash)
    articleHash["Abstract"]["AbstractText"]
  end

  def self.find_authors(articleHash)
    authorSet = articleHash["AuthorList"]["Author"]
    if authorSet.class == [].class
      authorSet.map do |author|
        "#{author["LastName"]} #{author["Initials"]}"
      end.join(", ")
    else
      "#{authorSet["LastName"]} #{authorSet["Initials"]}"
    end
  end

  def self.find_journal(articleHash)
    articleHash["Journal"]["Title"]
  end



end
