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
    @products = Product.where(exhibitor_id: current_user.id, purchaser_id: nil).order('created_at DESC').limit(18)
  end

  def purchaser
    @parents = Category.where(ancestry:nil)
    @products = Product.where(exhibitor_id: current_user.id).where.not(purchaser_id: nil).order('created_at DESC').limit(18)
  end


end
