class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name, index: {unique: true}
      t.string :status, null: false, default:'CREATED'
      t.integer :columns, null: false, default: 20
      t.integer :lines, null: false, default: 16
      t.integer :mines_total, null: false, default: 99
 
      t.timestamps
    end
  end
end
