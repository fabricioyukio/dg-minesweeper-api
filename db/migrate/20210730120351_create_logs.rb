class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.string :event
      t.string :description
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
