class KeywordsController < ApplicationController
  def create
    current_user.keywords.build(keyword_params)
    if current_user.save
      respond_to do |format|
        format.js
      end
    else
      redirect root_path
    end
  end
  private
    def keyword_params
      params.require(:keyword).permit(:name, :user_id)
    end
end
