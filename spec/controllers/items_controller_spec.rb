require 'rails_helper'
  describe ItemsController do
    let(:category) { create(:category) }
    let(:size) { create(:productsSize) }
    let(:brand) { create(:brand, category_id: category) }
    let(:user) { create(:user) }

    describe "DELETE #destroy" do
      it "該当するデータが削除される" do
        product = create(:product, category: category, brand: brand, products_size: size, exhibitor: user)
        expect{
          delete :destroy, params: {id: product}
        }.to change(Product, :count).by(-1)
      end
      it "rootにリダイレクトされる" do
        delete :destroy, params: {id: product}
        expect(response).to redirect_to items_path
      end
      it "flash[:notice]にメッセージが含まれる" do
        delete :destroy, params: {id: product}
        expect(flash[:notice]).to eq("出品した商品を削除しました")
      end
    end
  end

