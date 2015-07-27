class KeywordsController < ApplicationController
  def create
    current_user.keywords.build(keyword_params)
    current_user.save
    # binding.pry
  end
  private
    def keyword_params
      params.require(:keyword).permit(:name, :user_id)
    end
end
