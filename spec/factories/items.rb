FactoryBot.define do

  factory :item, class: Product do
    product_name {"sss"}
    product_introduction {"xxx"}
    category_id {"vvv"}
    product_status {"新品"}
    delivery_charge {"着払い"}
    delivery_method {"クロネコ"}
    delivery_area {"北海"}
    delivery_days {"1~2日"}
    price {"10"}
  end

end
