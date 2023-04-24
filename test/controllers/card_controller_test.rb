require "test_helper"

class CardControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get card_create_url
    assert_response :success
  end

  test "should get show" do
    get card_show_url
    assert_response :success
  end

  test "should get update" do
    get card_update_url
    assert_response :success
  end

  test "should get delete" do
    get card_delete_url
    assert_response :success
  end
end
