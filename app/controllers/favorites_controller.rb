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

  def email
    user = current_user
    receiver = params[:address]
    UserMailer.email_favorites(user, receiver).deliver_now
    @articles = current_user.favorites
    flash.now[:notice] = "Email sent!"
    render 'index'
  end

end
