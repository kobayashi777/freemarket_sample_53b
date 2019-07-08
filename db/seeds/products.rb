# Product.create!(product_name: "テスト", product_introduction: 'テストのやつです', category_id: "2", products_size_id: "2", brand_id: "1", price: '1000', created_at: '2019-05-24', updated_at: '2019-05-24') まずは１行作ってみて、その後複数作成

100.times do |n|
  Product.create!(product_name: "シード#{n}回目",product_introduction: "シード#{n}回目",category_id: "2",products_size_id: "2",brand_id: "1",price: "1200 + #{n}",created_at: "2019-07-08",updated_at: "2019-07-08")
end

# brand_idは1しかないので固定  他はnにしても数が足りるのでnにした