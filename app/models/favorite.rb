class Favorite < ActiveRecord::Base
  belongs_to :user

  def url
    "http://www.ncbi.nlm.nih.gov/pubmed/?term=#{self.id_from_json}"
  end
  
end
