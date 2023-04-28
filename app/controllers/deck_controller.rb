class DeckController < ApplicationController
  include Authenticatable
  def create
    return unless authenticate_request
    deck = Deck.new(name: params[:name], private: params[:private], user_id: @current_user.id)
    if deck.save
      redirect_to action: 'show', id: deck.id
    else
      redirect_to controller: :error, action: :handle
    end
  end

  def new
    authenticate_request
  end

  def show
    check_authenticated
    @deck = Deck.where(id: params[:id]).first
    if @deck.nil?
      redirect_to controller: :error, action: :handle
      return
    end
    if @deck.private?
      if @current_user.nil?
        redirect_to controller: :error, action: :handle
      elsif @deck.user_id != @current_user.id
        redirect_to controller: :error, action: :handle
      end
    end
  end

  def index
    check_authenticated
  end

  def delete
    return unless authenticate_request
    deck = Deck.where(id: params[:id]).first
    if deck.nil?
      redirect_to controller: :error, action: :handle
      return
    end
    if @current_user.id != deck.user_id
      redirect_to controller: :error, action: :handle
      return
    end
    if deck.destroy
      redirect_to action: 'index'
    else
      redirect_to controller: :error, action: :handle
    end
  end

  def update
    return unless authenticate_request
    deck = Deck.where(id: params[:id]).first
    if deck.nil?
      redirect_to controller: :error, action: :handle
      return
    end
    if @current_user.id != deck.user_id
      redirect_to controller: :error, action: :handle
      return
    end
    if deck.update(name: params[:name], private: params[:private])
      redirect_to action: :show, id: deck.id
    else
      redirect_to controller: :error, action: :handle
    end
  end
end
