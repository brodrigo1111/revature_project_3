def doSetup
    setup do
      @user1 = users(:user1)
      @user2 = users(:user2)
      @deck1 = decks(:deck1)
      @deck2 = decks(:deck2)
      @card1 = cards(:card1)
      @card2 = cards(:card2)
    end
end