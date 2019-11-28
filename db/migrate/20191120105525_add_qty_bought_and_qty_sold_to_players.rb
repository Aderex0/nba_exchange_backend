class AddQtyBoughtAndQtySoldToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :qtyBought, :integer
    add_column :players, :qtySold, :integer
  end
end
