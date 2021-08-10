class FixOwnershipBetweenGameAndPlayer < ActiveRecord::Migration[6.1]
  def change
    remove_reference :players, :game, null: false, foreign_key: true
    # one player owns the game
    add_reference :games, :player, null: false, foreign_key: true
  end
end
