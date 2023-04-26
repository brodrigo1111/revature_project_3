require "test_helper"

class DeckControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:user1)
    @user2 = users(:user2)
    @deck1 = decks(:deck1)
    @deck2 = decks(:deck2)
    @card1 = cards(:card1)
    @card2 = cards(:card2)
  end

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
end
