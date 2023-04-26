class CardController < ApplicationController
  include Authenticatable
  def create
    return unless authenticate_request
    deck = Deck.where(id: params[:id]).first
    if deck.nil?
      redirect_to controller: :error, action: :handle
      return
    end
    if @current_user.id != deck.user_id
      redirect_to controller: :session, action: :create
      return
    end
    card = Card.new(front: params[:front], back: params[:back], deck_id: params[:id])
    if card.save
      redirect_to controller: 'deck', action: 'show', id: params[:id]
    else
      redirect_to controller: :error, action: :handle
    end
  end

  def update
    return unless authenticate_request
    card = Card.find(params[:id])
    if @current_user.id != card.deck.user.id
      redirect_to controller: :session, action: :create
      return
    end
    if card.update(front: params[:front], back: params[:back])
      redirect_to controller: 'deck', action: 'show', id: card.deck_id
    else
      redirect_to controller: :error, action: :handle
    end
  end

  def delete
    return unless authenticate_request
    card = Card.find(params[:id])
    if @current_user.id != card.deck.user.id
      redirect_to controller: :session, action: :create
      return
    end
    deck_id = card.deck_id
    if card.destroy
      redirect_to controller: 'deck', action: 'show', id: deck_id
    else
      redirect_to controller: :error, action: :handle
    end
  end
end
