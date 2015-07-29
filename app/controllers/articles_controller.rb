class ArticlesController < ApplicationController
  def create
    
    current_user.keywords.each do |keyword|
      keyword.get_all_recent_abstracts2(current_user)
    end
    respond_to do |format|
      format.js
    end
  end
  def index
    @user = current_user
    @articles = @user.articles
    render "user_mailer/daily_result_email"
  end
end
