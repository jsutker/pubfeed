class HomeController < ApplicationController
  def index
    @keyword = Keyword.new
  end
end
