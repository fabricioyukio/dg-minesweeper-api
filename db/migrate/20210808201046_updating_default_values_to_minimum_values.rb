class UpdatingDefaultValuesToMinimumValues < ActiveRecord::Migration[6.1]
  def change
    change_column :games, :columns, :integer, null: false, default: 4
    change_column :games, :lines, :integer, null: false, default: 4
    change_column :games, :mines_total, :integer, null: false, default: 3
  end
end
