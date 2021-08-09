class GridControlsToGame < ActiveRecord::Migration[6.1]
  def change
    change_table :games do |t|
      t.jsonb :grid, null: false, default: {}
    end  
  end
end
