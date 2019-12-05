class AddGameIdToGameDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :game_details, :gameId, :integer
  end
end
