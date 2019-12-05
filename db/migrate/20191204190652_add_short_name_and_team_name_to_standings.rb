class AddShortNameAndTeamNameToStandings < ActiveRecord::Migration[6.0]
  def change
    add_column :standings, :shortName, :string
    add_column :standings, :teamName, :string
  end
end
