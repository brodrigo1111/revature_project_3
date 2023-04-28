require "test_helper"
require_relative "../helpers/setup.rb"

class UserControllerTest < ActionDispatch::IntegrationTest
  doSetup

  test "should not get create" do
    get '/user/create'
    assert_redirected_to controller: :error, action: :handle
  end

  test "should post new user" do
    post '/user/create', params: {username: 'newuser', password: 'newpassword'}
    assert_redirected_to controller: :deck, action: :index
  end

  test "should not post new user if bad params" do
    post '/user/create', params: {username: 'newuserfgvdbdgnnwsnwsfngwsmtsnrwn', password: 'newpassword'}
    assert_redirected_to controller: :error, action: :handle
  end

  test "should not post new user if already logged in" do
    post '/login', params: {username: @user1.username, password: 'PASSWORD1'}
    post '/user/create', params: {username: 'newuserfgvdbdgnnwsnwsfngwsmtsnrwn', password: 'newpassword'}
    assert_redirected_to controller: :error, action: :handle
  end

end
