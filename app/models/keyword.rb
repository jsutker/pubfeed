class Keyword < ActiveRecord::Base
  has_many :user_keywords
  has_many :users, through: :user_keywords
  has_many :keyword_articles
  has_many :articles, through: :keyword_articles
  validates :name, presence: true
  validates :name, uniqueness: true

  BASE_URL = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&retmax=1000&term="

  DATE_URL = "Date+-+Entrez%5D+%3A+%223000%22%5BDate+-+Entrez%5D)"

  #so this is just for one keyword right now

  def format_keyword
    "(#{self.name})"
  end

  def format_yesterday
    a = DateTime.now - 1
    b = a.to_s
    year = b[0,4]
    month = b[5,2]
    day = b[8,2]
    "+AND+(%22#{year}%2F#{month}%2F#{day}%22%5B"
  end

  def recent_as_json
    JSON.load(RestClient.get(BASE_URL + format_keyword + format_yesterday + DATE_URL))
  end

  def recent_id_array
    recent_as_json["esearchresult"]["idlist"]
  end

  def get_abstract_xml_as_json(id_from_json)
    xml = RestClient.get("http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&rettype=abstract&id=#{id_from_json}")
    json = Crack::XML.parse(xml)
    articleHash = json["PubmedArticleSet"]["PubmedArticle"]["MedlineCitation"]["Article"]
    @article = Article.find_or_create_by(title: title(articleHash), abstract: abstract(articleHash), id_from_json: id_from_json, journal: journal(articleHash), authors: authors(articleHash))
    self.articles << @article
  end

  def get_all_recent_abstracts
    recent_id_array.collect do |id|
      get_abstract_xml_as_json(id) 
    end
  end

  def collect_recent_titles
    get_all_recent_abstracts.collect do |article|
      title(article)
    end
  end

  def collect_recent_urls
    get_all_recent_abstracts.collect do |article|
      url(article)
    end
  end

  def title(articleHash)
    articleHash["ArticleTitle"]
  end

  def abstract(articleHash)
    articleHash["Abstract"]["AbstractText"]
  end

  def authors(articleHash)
    authorSet = articleHash["AuthorList"]["Author"]
    if authorSet.class == [].class
      authorSet.map do |author|
        "#{author["LastName"]} #{author["Initials"]}"
      end.join(", ")
    else
      "#{authorSet["LastName"]} #{authorSet["Initials"]}"
    end
  end

  def journal(articleHash)
    articleHash["Journal"]["Title"]
  end

end
