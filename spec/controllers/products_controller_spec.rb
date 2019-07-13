require 'rails_helper'

# viewの遷移のテスト

describe ProductsController do
  let(:category) { create(:category) }
  let(:size) { create(:productsSize) }
  let(:brand) { create(:brand, category_id: category) }
  let(:user) { create(:user) }

  context 'log out' do

    describe 'GET #index' do
      it "renders the :index template" do
      get :index
      expect(response).to render_template :index
      end

      # インスタンス変数の値が期待したものになるか
      it "assigns the requested product to @products" do
        product = create_list(:product, 3, category: category, brand: brand, products_size: size, exhibitor: user)
        get :index, params: { id: product }
        expect(assigns(:products)).to eq product
      end
    end

    # ログアウト時には出品ページに行くと、ログイン画面に飛ぶ
    describe 'GET #new' do
      it "redirect_to signin page" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    # ログアウト時には商品編集ページに行くと、ログイン画面に飛ぶ
    describe 'GET #edit' do
      it "redirect_to signin page" do
        product = create(:product, category: category, brand: brand, products_size: size, exhibitor: user)
        get :edit, params: { id: product}
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  # ログイン時の挙動
  context 'log in' do
    before do
      login user
    end

    describe 'GET #new' do
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context '入力に不備がない場合' do
        it "creates a product record in DB" do
          expect{
            post :create, params: {
              product: attributes_for(:product), delivery_method: "クロネコヤマト", category_id: category, brand_id: brand, products_size_id: size, exhibitor_id: user
            }
          }.to change(Product, :count).by(1)
        end
      end

      context '入力に不備がある場合' do
        it "renders the :new template" do
          post :create, params: {
            product: attributes_for(:product, product_name: nil), delivery_method: "クロネコヤマト", category_id: category, brand_id: brand, products_size_id: size, exhibitor_id: user
          }
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit'do
      it "renders the :edit template" do
        product = create(:product, category: category, brand: brand, products_size: size, exhibitor: user)
        get :edit, params: { id: product}
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      context '入力に不備がない場合' do
        it "does not create a product record in DB" do
          product = create(:product, category: category, brand: brand, products_size: size, exhibitor: user)
          expect{
            patch :update, params: {
              id: product.id, product: attributes_for(:product), delivery_method: "クロネコヤマト", category_id:category,brand_id:brand,products_size_id:size, exhibitor_id: user, delete_photos: ""
            }
          }.to change(Product, :count).by(0)
        end
      end

      context '入力に不備がある場合' do
        it "redirect to edit page" do
          product = create(:product, category: category, brand: brand, products_size: size, exhibitor: user)
          patch :update, params: {
            id: product.id, product: attributes_for(:product, product_name: nil), delivery_method: "クロネコヤマト", category_id:category,brand_id:brand,products_size_id:size, exhibitor_id: user, delete_photos: ""
          }
          expect(response).to redirect_to edit_product_path
        end
      end
    end

  end

end