class Keyword < ActiveRecord::Base
  has_many :user_keywords
  has_many :users, through: :user_keywords
  has_many :keyword_articles
  has_many :articles, through: :keyword_articles
  validates :name, presence: true
  validates :name, uniqueness: true

  include Dateable

  BASE_URL = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&retmax=1000&term=("

  DATE_URL = "Date+-+Entrez%5D+%3A+%223000%22%5BDate+-+Entrez%5D)"

  def recent_id_array
    JSON.load(RestClient.get(BASE_URL + self.name + format_yesterday + DATE_URL))["esearchresult"]["idlist"]
  end

  def get_abstract_info(id)
    xml = RestClient.get("http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&rettype=abstract&id=#{id}")
    json = Crack::XML.parse(xml)
    json["PubmedArticleSet"]["PubmedArticle"]["MedlineCitation"]["Article"]
  end

  def hydrate_article(id)
    articleHash = get_abstract_info(id)
    article = Article.find_or_create_abstracts(articleHash, id)
    self.articles << article
  end 

  def get_all_recent_abstracts
    recent_id_array.collect do |id|
      hydrate_article(id)
    end
  end

end
