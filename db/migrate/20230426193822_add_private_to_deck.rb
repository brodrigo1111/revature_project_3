class AddPrivateToDeck < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :private, :boolean
  end
end
