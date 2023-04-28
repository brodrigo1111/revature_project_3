require "test_helper"
require_relative "../helpers/setup.rb"

class SessionControllerTest < ActionDispatch::IntegrationTest
  doSetup

  test "should get login" do
    get '/login'
    assert_response :success
  end

  test "should post login" do
    post '/login', params: { username: @user1.username, password: 'PASSWORD1'}
    assert_redirected_to controller: :deck, action: :index
  end

  test "should not post login with bad password" do
    post '/login', params: { username: @user1.username, password: 'BADPASSWORD'}
    assert_redirected_to action: :bad
  end

  test "should not post login with bad username" do
    post '/login', params: { username: 'BADUSERNAME', password: 'BADPASSWORD'}
    assert_redirected_to action: :bad
  end

end
