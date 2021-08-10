class AddCompositeIndexToSessions < ActiveRecord::Migration[6.1]
  def change
    add_index :sessions, [:game_id, :player_id], unique: true
  end
end
