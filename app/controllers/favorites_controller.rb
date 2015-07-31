class FavoritesController < ApplicationController

  def index
    @articles = current_user.favorites
    respond_to do |format|
      format.js
    end
  end

  def update
    favorite = Favorite.find(params[:id])
    favorite.destroy
    @articles = current_user.favorites
  
    respond_to do |format|
      format.js
    end
  end

end
