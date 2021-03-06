class KeywordsController < ApplicationController

  def create
    respond_to do |format|
      if !(current_user.keywords.exists?(name: params[:keyword][:name]))
        @keyword = Keyword.find_or_create_by(name: params[:keyword][:name])
        current_user.keywords << @keyword
        format.js
      else
        format.js {render :js=>'$("#keyword_name").val("");alert("Invalid/Used keyword");'}
      end
    end
  end

  def filter
    if !(params[:keyword][:id].empty?)
      @keyword = Keyword.find(params[:keyword][:id])
      @articles = @keyword.articles
    else
      @articles = current_user.articles
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    keyword = Keyword.find(params[:id])
    @keyword = keyword
    @articles = current_user.articles
    current_user.keywords.delete(keyword)
    current_user.save
    respond_to do |format|
      format.js
    end
  end


end
