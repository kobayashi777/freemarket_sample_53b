FactoryBot.define do

  factory :product do
    product_name {"aaa"}
    product_introduction {"bbb"}
    product_status {"新品、未使用"}
    delivery_charge {"着払い（購入者負担）"}
    delivery_method {"クロネコヤマト"}
    delivery_area {"北海道"}
    delivery_days {"1~2日で発送"}
    price {"1000"}
  end

end   