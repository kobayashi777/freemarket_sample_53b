class Product < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  belongs_to :product_size
end
