class Product < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  belongs_to :products_size

  # バリデーション
  validates :price,  numericality: {only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9999999  }

end
