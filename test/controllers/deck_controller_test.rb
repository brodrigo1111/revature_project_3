require "test_helper"

class DeckControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get deck_create_url
    assert_response :success
  end

  test "should get show" do
    get deck_show_url
    assert_response :success
  end

  test "should get update" do
    get deck_update_url
    assert_response :success
  end

  test "should get delete" do
    get deck_delete_url
    assert_response :success
  end
end
