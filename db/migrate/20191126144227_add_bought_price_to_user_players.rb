class AddBoughtPriceToUserPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :user_players, :boughtPrice, :float
  end
end
