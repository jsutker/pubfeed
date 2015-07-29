class HomeController < ApplicationController
  def index
    if current_user
      @keyword = Keyword.new
      @articles = current_user.articles
    end
  end
end
