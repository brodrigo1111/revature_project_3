class DeckController < ApplicationController
  def create
    deck = Deck.new(name: params[:name])
    if deck.save
      redirect_to action: 'show', id: deck.id
    else
      render response: :unprocessable_entity
    end
  end

  def new
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def index
  end

  def update
  end

  def delete
  end
end
