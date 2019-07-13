class MypageController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

end
