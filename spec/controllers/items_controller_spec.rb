require 'rails_helper'
  describe ItemsController do
    describe "DELETE #destroy" do
      let(:category) { create(:category) }
      let(:size) { create(:productsSize) }
      let(:brand) { create(:brand, category_id: category) }
      let(:user) { create(:user) }
      it 'deletes the product' do
        product = create(:product, category: category, brand: brand, products_size: size, exhibitor: user)
        expect{
          delete :destroy, params: {id: product}
        }.to change(Product, :count).by(-1)
      end
    end
  end
