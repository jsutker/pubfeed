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
    if /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.match(params[:address])
      receiver = params[:address]
      flash.now[:notice] = "Email sent!"
      UserMailer.email_favorites(user, receiver).deliver_now
    else
      flash.now[:notice] = "Please enter a valid email address."
    end

    @articles = current_user.favorites
    render 'index'
  end

end
