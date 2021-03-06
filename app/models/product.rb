class Product < ApplicationRecord
  has_many_attached :photos
  belongs_to :exhibitor, class_name: 'User', foreign_key: :exhibitor_id, optional: true
  belongs_to :purchaser, class_name: 'User', foreign_key: :purchaser_id, optional: true
  belongs_to :brand, optional: true
  belongs_to :category
  belongs_to :products_size, optional: true

  # バリデーション
  validates :photos, length: { in: 1..10, message: "は1枚以上10枚以下で選択してください"}, on: :create
  validates :product_name, length: { in: 1..40 }
  validates :product_introduction, length: { in: 1..1000 }
  validates :category_id, numericality: {message: 'を選択してください'}
  validates :products_size_id, numericality: {message: 'を選択してください'}, allow_nil: true
  validates :product_status, presence: {
    if: proc { |d| d.product_status == nil },
    message: 'を選択してください' 
  }
  validates :delivery_charge, exclusion: {in: %w(---), message: 'を選択してください'}
  validates :delivery_method, exclusion: {in: %w(---), message: 'を選択してください'}
  validates :delivery_area, exclusion: {in: %w(---), message: 'を選択してください'}
  validates :delivery_days, exclusion: {in: %w(---), message: 'を選択してください'}
  validates :price,  numericality: {only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9999999,
                                    message: 'は300以上9999999以下で入力してください' }

  enum delivery_charge: {
  "---":0,送料込み（出品者負担）:1,着払い（購入者負担）:2
  }

  enum delivery_area:{
  "---":0,
  北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
  茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
  新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
  岐阜県:21,静岡県:22,愛知県:23,三重県:24,
  滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
  鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
  徳島県:36,香川県:37,愛媛県:38,高知県:39,
  福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  },_prefix: true

  enum delivery_days:{
  "---":0,
  "1~2日で発送":1, "2~3日で発送":2, "4~7日で発送":3
},_prefix: true

  enum product_status:{"新品、未使用": 1, "未使用に近い": 2, "目立った傷や汚れなし": 3, "やや傷や汚れあり": 4, "傷や汚れあり": 5, "全体的に状態が悪い": 6}
end
