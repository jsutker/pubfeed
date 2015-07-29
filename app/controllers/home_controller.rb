class HomeController < ApplicationController
  def index
    @keyword = Keyword.new
    @articles = current_user.articles
  end
end
