class ArticlesController < ApplicationController
  def create
    @articles = current_user.articles
    current_user.keywords.each do |keyword|
      if keyword.articles.empty?
        keyword.get_all_recent_abstracts
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def index
    @keyword = Keyword.new
    @articles = current_user.articles
    current_user.keywords.each do |keyword|
      if keyword.articles.empty?
        keyword.get_all_recent_abstracts
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    articles = current_user.articles
    @articles = articles
    article = Article.find(params[:id])
    f = Favorite.create(title: article.title, abstract: article.abstract, id_from_json: article.id_from_json, authors: article.authors, journal: article.journal, user_id: current_user.id )
    respond_to do |format|
      format.js
    end
  end
end
