require 'rails_helper'

describe Product do
  let(:category) { create(:category) }
  let(:size) { create(:productsSize) }
  let(:brand) { create(:brand, category_id: category) }
  let(:user) { create(:user) }
  
  # 全てのインプットありの場合
  it "is valid with all inputs" do
    product = build(:product, category: category, brand: brand, products_size: size, exhibitor: user)
    expect(product).to be_valid
  end

  # 商品名関連
  it "is invalid without a product_name" do
    product = build(:product, product_name: nil, category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:product_name]).to include("は1文字以上で入力してください")
  end
  
  it "is invalid with a product_name that has more than 40 characters " do
    product = build(:product, product_name: Faker::String.random([41]), category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:product_name]).to include("は40文字以内で入力してください")
  end

  # 商品説明関連
  it "is invalid without a product_introduction" do
    product = build(:product, product_introduction: nil, category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:product_introduction]).to include("は1文字以上で入力してください")
  end

  it "is invalid with a product_intordution that has more than 1000 characters" do
    product = build(:product, product_introduction: Faker::String.random([1001]), category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:product_introduction]).to include("は1000文字以内で入力してください")
  end

  # カテゴリー
  it "is invalid without a category_id" do
    product = build(:product, category_id: "---", brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:category_id]).to include("を選択してください")
  end
  
  # サイズ
  it "is invalid without a products_size_id" do
    product = build(:product, category: category, brand: brand, products_size_id: "---", exhibitor: user)
    product.valid?
    expect(product.errors[:products_size_id]).to include("を選択してください")
  end
  
  # 商品の状態
  it "is invalid without a product_status" do
    product = build(:product, product_status: nil, category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:product_status]).to include("を選択してください")
  end
  
  # 配送料の負担
  it "is invalid without a delivery_charge" do
    product = build(:product, delivery_charge: "---", category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:delivery_charge]).to include("を選択してください")
  end
  
  # 配送の方法
  it "is invalid without a delivery_methos" do
    product = build(:product, delivery_method: "---", category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:delivery_method]).to include("を選択してください")
  end
  
  # 配送元の地域
  it "is invalid without a delivery_area" do
    product = build(:product, delivery_area: "---", category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:delivery_area]).to include("を選択してください")
  end

  # 配送までの日数
  it "is invalid without a delivery_days" do
    product = build(:product, delivery_days: "---", category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:delivery_days]).to include("を選択してください")
  end
  
  # 価格関連
  it "is invalid without a price" do
    product = build(:product, price: nil, category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:price]).to include("は300以上9999999以下で入力してください")
  end

  it "is invalid with a price less than 299" do
    product = build(:product, price: 288, category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:price]).to include("は300以上9999999以下で入力してください")
  end

  it "is invalid with a price more than 9999999" do
    product = build(:product, price: 10000000, category: category, brand: brand, products_size: size, exhibitor: user)
    product.valid?
    expect(product.errors[:price]).to include("は300以上9999999以下で入力してください")
  end

end