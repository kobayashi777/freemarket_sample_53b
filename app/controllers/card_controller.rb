class CardController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],)
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id:customer.default_card)
      if @card.save
        redirect_to controller: 'purchase', action: 'index'
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
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end