require 'rails_helper'

describe CardController, type: :controller do

  describe 'Get #pay' do

  it "renders the :index template" do
    redirect_to controller: 'purchase', action: 'index'
  end
end

end