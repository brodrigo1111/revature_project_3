require "test_helper"
require_relative "../helpers/setup.rb"

class DeckControllerTest < ActionDispatch::IntegrationTest
  doSetup

  test "should not get create" do
    get '/deck/create'
    assert_redirected_to controller: :session, action: :new
  end

  test "should not get new if unauthorized" do
    get '/logout'
    get '/deck/create'
    assert_redirected_to controller: :session, action: :new
  end

  test "should get new if authorized" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    get '/deck/create'
    assert_response :success
  end

  test "should get show" do
    get '/deck/' + @deck1.id.to_s
    assert_response :success
  end

  test "should get index" do
    get '/'
    assert_response :success
  end

  test "should not get update" do
    get '/deck/update/' + @deck1.id.to_s
    assert_redirected_to controller: :error, action: :handle
  end

  test "should not get delete" do
    get '/deck/delete/' + @deck1.id.to_s
    assert_redirected_to controller: :error, action: :handle
  end

  test "should not get show for private deck when unauthenticated" do
    get '/deck/' + @deck2.id.to_s
    assert_redirected_to controller: :error, action: :handle
  end

  test "should get show for private deck when owner" do
    post '/login', params: {username: 'USER2', password: 'PASSWORD2'}
    get '/deck/' + @deck2.id.to_s
    assert_response :success
  end

  test "should not get show for private deck when not owner" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    get '/deck/' + @deck2.id.to_s
    assert_redirected_to controller: :error, action: :handle
  end

  test "should not update when unauthenticated" do
    put '/deck/update/' + @deck1.id.to_s, params: {name: 'new name', private: true}
    assert_redirected_to controller: :session, action: :new
    assert Deck.where(id: @deck1.id).first.name != 'new name'
    assert Deck.where(id: @deck1.id).first.private == false
  end

  test "should update when owner" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    put '/deck/update/' + @deck1.id.to_s, params: {name: 'new name', private: true}
    assert_redirected_to controller: :deck, action: :show, id: @deck1.id
    assert Deck.where(id: @deck1.id).first.name == 'new name'
    assert Deck.where(id: @deck1.id).first.private == true
  end

  test "should not update when not owner" do
    post '/login', params: {username: 'USER2', password: 'PASSWORD2'}
    put '/deck/update/' + @deck1.id.to_s, params: {name: 'new name', private: true}
    assert_redirected_to controller: :error, action: :handle
    assert Deck.where(id: @deck1.id).first.name != 'new name'
    assert Deck.where(id: @deck1.id).first.private == false
  end

  test "should not delete when unauthenticated" do
    delete '/deck/delete/' + @deck1.id.to_s
    assert_redirected_to controller: :session, action: :new
    assert Deck.where(id: @deck1.id) != []
  end

  test "should delete when owner" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    delete '/deck/delete/' + @deck1.id.to_s
    assert_redirected_to controller: :deck, action: :index
    assert Deck.where(id: @deck1.id) == []
  end

  test "should not delete when not owner" do
    post '/login', params: {username: 'USER2', password: 'PASSWORD2'}
    delete '/deck/delete/' + @deck1.id.to_s
    assert_redirected_to controller: :error, action: :handle
    assert Deck.where(id: @deck1.id) != []
  end

  test "should not create if unauthenticated" do
    post '/deck/create', params: {name: 'NEW DECK', private: false}
    deck = Deck.where(name: 'NEW DECK').first
    assert_redirected_to controller: :session, action: :new
    assert deck.nil?
  end

  test "should create if authenticated" do
    post '/login', params: {username: 'USER1', password: 'PASSWORD1'}
    post '/deck/create', params: {name: 'NEW DECK', private: false}
    deck = Deck.where(name: 'NEW DECK').first
    assert_redirected_to controller: :deck, action: :show, id: deck.id
    assert deck
  end
end
