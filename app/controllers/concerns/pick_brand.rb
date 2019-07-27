module PickBrand
  extend ActiveSupport::Concern

  private

  # ブランドに紐づく商品を最新順に4つ取り出す
  def pick_brand(brand)
    pick_brand=Brand.where(name: "#{brand}")
    brand=[]
    pick_brand.each do |record|
      record.products.each do |product|
        brand<<product
      end
    end
    brand.sort_by!{ |a| a[:updated_at] }.reverse![0..3]
  end
end