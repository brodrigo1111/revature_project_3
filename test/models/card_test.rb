require "test_helper"
require_relative "../helpers/setup.rb"

class CardTest < ActiveSupport::TestCase
  doSetup

  test "card fails when name > 100 characters" do
    begin
      Card.create(front: '1', back: "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901", deck_id: @deck1.id)
    rescue ActiveRecord::RecordInvalid
      assert_raises(ActiveRecord::RecordInvalid)
    end
  end

  test "card succeeds when name < 101 characters" do
    assert Card.create(front: "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890", back: '1', deck_id: @deck1.id)
  end

  test "card fails when front missing" do
    begin
      Card.create(back: '1', deck_id: @deck1.id)
    rescue ActiveRecord::RecordInvalid
      assert_raises(ActiveRecord::RecordInvalid)
    end
  end

  test "card fails when back missing" do
    begin
      Card.create(front: "1", deck_id: @deck1.id)
    rescue ActiveRecord::RecordInvalid
      assert_raises(ActiveRecord::RecordInvalid)
    end
  end
end
