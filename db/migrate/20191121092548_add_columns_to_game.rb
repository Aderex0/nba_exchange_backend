class AddColumnsToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :statusGame, :string
    add_column :games, :vTeamId, :integer
    add_column :games, :vTeamShortName, :string
    add_column :games, :hTeamId, :integer
    add_column :games, :hTeamShortName, :string
    add_column :games, :startTime, :string
  end
end
