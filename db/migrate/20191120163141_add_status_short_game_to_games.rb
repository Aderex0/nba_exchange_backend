class AddStatusShortGameToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :statusShortGame, :integer
  end
end
