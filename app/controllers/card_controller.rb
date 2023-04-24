class CardController < ApplicationController
  def create
    card = Card.new(front: params[:front], back: params[:back], deck_id: params[:id])
    if card.save
      puts "ok"
      redirect_to controller: 'deck', action: 'show', id: params[:id]
    else
      render response: :unprocessable_entity
    end
  end

  def show
  end

  def update
  end

  def delete
  end
end
