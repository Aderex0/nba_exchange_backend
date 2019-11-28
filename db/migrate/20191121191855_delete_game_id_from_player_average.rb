class DeleteGameIdFromPlayerAverage < ActiveRecord::Migration[6.0]
  def change
    remove_column :player_averages, :gameId
  end
end
