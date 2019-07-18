require 'rails_helper'
  describe Product do
    describe "#destroy" do
      it 'deletes the product' do
        product = create(:item)
        expect{
          delete :destroy, params: {id: product}
        }.to change(Product, :count).by(-1)
      end
    end
  end
