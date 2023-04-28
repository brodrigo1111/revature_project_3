require "test_helper"
require_relative "../helpers/setup.rb"

class CardControllerTest < ActionDispatch::IntegrationTest
  doSetup

  test "should not get create" do
    get '/card/create/1'
    assert_redirected_to controller: :error, action: :handle
  end

  test "should not get update" do
    get '/card/update/1'
    assert_redirected_to controller: :error, action: :handle
  end

  test "should not get delete" do
    get '/card/delete/1'
    assert_redirected_to controller: :error, action: :handle
  end

  test "should update card" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    put '/card/update/' + @card1.id.to_s, params: { front: "I AM A FRONT", back: "I AM A BACK"}
    assert_redirected_to controller: :deck, action: :show, id: @card1.deck_id
    card = Card.find(@card1.id)
    assert "I AM A FRONT" == card.front
    assert "I AM A BACK" == card.back
  end

  test "should delete card" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    delete '/card/delete/' + @card1.id.to_s
    assert_redirected_to controller: :deck, action: :show, id: @card1.deck_id
    assert Card.where(id: @card1.id) == []
  end

  test "should not update card if unauthenticated" do
    put '/card/update/' + @card1.id.to_s, params: { front: "I AM A FRONT", back: "I AM A BACK"}
    assert_redirected_to controller: :session, action: :create
  end

  test "should not delete card if unauthenticated" do
    delete '/card/delete/' + @card1.id.to_s
    assert_redirected_to controller: :session, action: :create
  end

  test "should not update card if wrong user" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    put '/card/update/' + @card2.id.to_s, params: { front: "I AM A FRONT", back: "I AM A BACK"}
    assert_redirected_to controller: :session, action: :create
  end

  test "should not delete card if wrong user" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    delete '/card/delete/' + @card2.id.to_s
    assert_redirected_to controller: :session, action: :create
  end
end


