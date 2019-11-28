class AddPricesToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :sell, :float
    add_column :players, :buy, :float
  end
end
