class AddForeignKeyToDecks < ActiveRecord::Migration[7.0]
  def change
    add_reference :decks, :user, foreign_key: true
  end
end
