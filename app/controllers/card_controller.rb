class CardController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    
    # Payjp.api_key = Rails.application.credentials.PAYJP_PRIVATE_KEY
    Payjp.api_key = "sk_test_8a22f3d6cc423679a2d3e948"
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],)
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id:customer.default_card)
      if @card.save
        redirect_to purchase_path(session[:product_id])
      else
        redirect_to action: "pay"
      end
    end
  end


  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      # Payjp.api_key = Rails.application.credentials.PAYJP_PRIVATE_KEY
      Payjp.api_key = "sk_test_8a22f3d6cc423679a2d3e948"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
