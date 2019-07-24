class MypageController < ApplicationController


  def index
    @parents = Category.where(ancestry:nil)
  end

  def show
    @parents = Category.where(ancestry:nil)
  end

  def new
    @parents = Category.where(ancestry:nil)
  end
  
  def exhibit
    @parents = Category.where(ancestry:nil)
    @products = Product.where(exhibitor_id: current_user.id).order('created_at DESC').limit(18)
  end


end
