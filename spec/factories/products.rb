FactoryBot.define do
  factory :product do
    sequence(:product_name) {"名前"}
    sequence(:category_id) {"カテゴリー"}
    sequence(:brand_id) {"ブランド"}
    sequence(:product_introduction) {"説明"}
    sequence(:product_status) {"新品、未使用"}
    sequence(:delivery_charge) {"送料込み(出品者負担)"}
    sequence(:delivery_method) {"未定"}
    sequence(:delivery_area) {"北海道"}
    sequence(:delivery_days) {"1〜2日で発送"}
    sequence(:price) {"300"}
    sequence(:create_id) {"TEST01"}
    sequence(:update_id) {"TEST01"}
  end
end