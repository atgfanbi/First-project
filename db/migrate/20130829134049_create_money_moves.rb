class CreateMoneyMoves < ActiveRecord::Migration
  def change
    create_table :money_moves do |t|
      t.float :price
      t.text :description
      t.datetime :date
      t.references :category
    end
    add_index :money_moves, :category_id
  end
end
