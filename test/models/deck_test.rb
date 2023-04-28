require "test_helper"
require_relative "../helpers/setup.rb"
class DeckTest < ActiveSupport::TestCase
  doSetup

  test "deck fails when name > 30 characters" do
    begin
      Deck.create(name: "1234567890123456789012345678901", private: true, user_id: @user1.id)
    rescue ActiveRecord::RecordInvalid
      assert_raises(ActiveRecord::RecordInvalid)
    end
  end

  test "deck succeeds when name < 31 characters" do
    assert Deck.create(name: "123456789012345678901234567890", private: true, user_id: @user1.id)
  end

  test "deck fails when name missing" do
    begin
      Deck.create(private: true, user_id: @user1.id)
    rescue ActiveRecord::RecordInvalid
      assert_raises(ActiveRecord::RecordInvalid)
    end
  end

  test "deck fails when private missing" do
    begin
      Deck.create(name: "1", user_id: @user1.id)
    rescue ActiveRecord::RecordInvalid
      assert_raises(ActiveRecord::RecordInvalid)
    end
  end

end
