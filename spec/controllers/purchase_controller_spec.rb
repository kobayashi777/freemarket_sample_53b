require 'rails_helper'

describe PurchaseController, type: :controller do

  describe 'Get #pay' do

  it "renders the :done template" do
    redirect_to action: 'done' 
  end
end

end