require 'rails_helper'

# viewの遷移のテスト

describe ProductsController do
  describe 'GET #index' do
    it "renders the :index template" do
    get :index
    expect(response).to render_template :index
    end
  end

  # インスタンス変数の値が期待したものになるか
  describe 'GET #index' do
    # product = FactoryBot.build(:product)
    it "assigns the requested product to @products" do
      category = Category.new(name:"aaa")
      brand = Brand.new(name:"aaa")
      size = ProductsSize.new(size:"10")
      # product = create(:product,category:category)
      product = create_list(:product,3,category:category,brand:brand,products_size:size)

      get :index, params: { id: product }
      expect(assigns(:products)).to eq product
    end
  end
end